// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:photo_manager/photo_manager.dart';
import 'package:photo_redactor/domain/Bloc/work_bloc.dart';
import 'package:photo_redactor/domain/Bloc/work_event.dart';
import 'package:photo_redactor/domain/models/work_model.dart';
import 'package:photo_redactor/presentation/providers/holst_page_provider.dart';
import 'package:photo_redactor/presentation/widgets/drawer_widget.dart';
import 'package:photo_redactor/presentation/widgets/edit_buttons_widget.dart';
import 'package:provider/provider.dart';

import 'media_picker.dart';

class HolstPage extends StatefulWidget {
  const HolstPage({super.key});

  @override
  State<HolstPage> createState() => _HolstPageState();
}

class _HolstPageState extends State<HolstPage>
    with SingleTickerProviderStateMixin {
  Future pickAssets({required RequestType requestType}) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MediaPicker(requestType: requestType);
    }));

    if (result != null) {
      setState(() {
        context.read<HolstPageProvider>().selectAsset(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<HolstPageProvider>().controller = TransformationController();
    context.read<HolstPageProvider>().animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        context.read<HolstPageProvider>().controller.value =
            context.read<HolstPageProvider>().animation!.value;
      });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<HolstPageProvider>();
    final watch = context.watch<HolstPageProvider>();
    return Scaffold(
        drawer: myDrawer(context),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text(
            'Redactor',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          actions: !watch.selectedAsset
              ? []
              : [
                  Padding(
                    padding: EdgeInsets.only(right: 45.w),
                    child: GestureDetector(
                        onLongPressStart: (val) {
                          read.checkstartsImage(!watch.isstartImage);
                        },
                        onLongPressEnd: (val) {
                          read.checkstartsImage(!watch.isstartImage);
                        },
                        child: Icon(watch.isstartImage
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 22.w),
                    child: GestureDetector(
                        onTap: () {
                          read.deleteSteps(1);
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) => deleteStepsDialog());
                        },
                        child: const Icon(Icons.rotate_left_outlined)),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => saveAs(),
                        );
                      },
                      icon: const Icon(Icons.save)),
                  const SizedBox(
                    width: 10,
                  )
                ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
                child: ValueListenableBuilder<Bitmap?>(
                    valueListenable: watch.imageValueNotifier,
                    builder:
                        (BuildContext context, Bitmap? bitmap, Widget? child) {
                      if (bitmap == null) {
                        return Container();
                      }
                      return SafeArea(
                        top: true,
                        child: GestureDetector(
                          onDoubleTapDown: (details) =>
                              read.tapDownDetails = details,
                          onDoubleTap: () {
                            final position = read.tapDownDetails!.localPosition;
                            const double scale = 3;
                            final x = -position.dx * (scale - 1);
                            final y = -position.dy * (scale - 1);
                            final zoomed = Matrix4.identity()
                              ..translate(x, y)
                              ..scale(scale);
                            final end = read.controller.value.isIdentity()
                                ? zoomed
                                : Matrix4.identity();

                            read.animation = Matrix4Tween(
                                    begin: read.controller.value, end: end)
                                .animate(CurveTween(curve: Curves.easeOut)
                                    .animate(read.animationController));
                            read.animationController.forward(from: 0);
                          },
                          child: InteractiveViewer(
                            clipBehavior: Clip.none,
                            transformationController: read.controller,
                            panEnabled: false,
                            scaleEnabled: false,
                            child: Image.memory(
                              bitmap.buildHeaded(),
                            ),
                          ),
                        ),
                      );
                    }))),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
            bottom: 50.h,
            right: 30.w,
          ),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !watch.selectedAsset
                    ? FloatingActionButton(
                        backgroundColor: Colors.orange,
                        onPressed: () {
                          pickAssets(requestType: RequestType.common);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(360)),
                        child: const Icon(Icons.add),
                      )
                    : EditButtonsWidget(
                        flipHImage: read.flipHImage,
                        rotateClockwiseImage: read.rotateCounterClockwiseImage,
                        rotateCounterClockwiseImage: read.rotateClockwiseImage,
                        contrastImage: read.contrastImage,
                        brightnessImage: read.brightnessImage,
                        adjustColorImage: read.adjustColorImage,
                        batchOperations: read.batchOperations,
                      )
              ]),
        ));
  }

  Widget deleteStepsDialog() {
    int countSteps = 0;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Сколько шагов назад?'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300.w,
              height: 100.h,
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.phone,
                onChanged: (val) =>
                    countSteps = val.isEmpty ? 0 : int.parse(val),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  context.read<HolstPageProvider>().deleteSteps(countSteps);
                  Navigator.pop(context);
                },
                child: const Text('Продолжить'))
          ],
        ),
      ),
    );
  }

  Widget saveAs() {
    String? name;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Название файла'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 500.w,
              height: 100.h,
              child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  keyboardType: TextInputType.text,
                  onChanged: (val) => name = val),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  if (name != null && name!.isNotEmpty) {
                    await context
                        .read<HolstPageProvider>()
                        .imageValueNotifier
                        .buildImage(name!);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Сохранить на устройстве')),
            SizedBox(
              height: 35.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                if (name != null && name!.isNotEmpty) {
                  String nameEndedFile = (await context
                          .read<HolstPageProvider>()
                          .imageValueNotifier
                          .buildImage(name!))
                      .path;
                  WorkModel thismodel = WorkModel(
                      actions: context.read<HolstPageProvider>().steps,
                      endedFileName: nameEndedFile,
                      startedFileName:
                          context.read<HolstPageProvider>().initialImage.path);
                  context
                      .read<WorkBloc>()
                      .add(AddWorkEvent(workModel: thismodel));
                  Navigator.pop(context);
                }
              },
              child: const Text('Сохранить в приложении '),
            ),
          ],
        ),
      ),
    );
  }
}
