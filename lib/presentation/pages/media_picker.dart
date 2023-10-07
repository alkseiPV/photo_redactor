// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_redactor/presentation/providers/holst_page_provider.dart';
import 'package:photo_redactor/presentation/services/media_services.dart';
import 'package:provider/provider.dart';

class MediaPicker extends StatefulWidget {
  final RequestType requestType;
  const MediaPicker({super.key, required this.requestType});

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  AssetEntity? selectedAssetList;
  final controller = ScrollController();
  int start = 0;
  int end = 30;

  @override
  void initState() {
    MediaServices().loadAlbums(widget.requestType).then((value) {
      setState(() {
        albumList = value;
        selectedAlbum = value[0];
      });
      //load assets
      MediaServices().loadAssets(selectedAlbum!, start, end).then((value) {
        setState(() {
          assetList = value;
        });
      });
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        pagination();
      }
    });
    super.initState();
  }

  Future pagination() async {
    MediaServices().loadAssets(selectedAlbum!, end, end + 30).then((value) {
      setState(() {
        assetList += value;
      });
    });
    start = end;
    end += 20;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () async {
                      ImagePicker picker = ImagePicker();
                      XFile? imagen =
                          await picker.pickImage(source: ImageSource.camera);
                      if (imagen != null) {
                        await context
                            .read<HolstPageProvider>()
                            .imageValueNotifier
                            .loadImage(File(imagen.path));
                        context.read<HolstPageProvider>().initialImage =
                            File(imagen.path);

                        Navigator.pop(context, true);
                      }
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.black,
                    ))
              ],
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: DropdownButtonHideUnderline(
                child: DropdownButton<AssetPathEntity>(
                  value: selectedAlbum,
                  onChanged: (AssetPathEntity? value) {
                    setState(() {
                      selectedAlbum = value;
                    });
                    MediaServices()
                        .loadAssets(selectedAlbum!, 0, 20)
                        .then((value) {
                      setState(() {
                        assetList = value;
                      });
                    });
                  },
                  items: albumList.map<DropdownMenuItem<AssetPathEntity>>(
                      (AssetPathEntity album) {
                    return DropdownMenuItem(
                        value: album,
                        child: Text(
                          album.name,
                        ));
                  }).toList(),
                ),
              ),
            ),
            body: assetList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    itemCount: assetList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      AssetEntity assetEntity = assetList[index];
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: InkWell(
                            onTap: () async {
                              await context
                                  .read<HolstPageProvider>()
                                  .imageValueNotifier
                                  .loadImage(
                                      await assetList[index].file as File);
                              context.read<HolstPageProvider>().initialImage =
                                  await assetList[index].file as File;

                              Navigator.pop(context, true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: AssetEntityImage(
                                assetEntity,
                                isOriginal: false,
                                thumbnailSize: const ThumbnailSize.square(250),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            )),
                      );
                    })));
  }
}
