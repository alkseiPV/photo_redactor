import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:bitmap/bitmap.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_redactor/presentation/services/image%20notifier/redactor_methods.dart';

class ImageValueNotifier extends ValueNotifier<Bitmap?> {
  ImageValueNotifier() : super(null);

  late Bitmap initial;
  late Bitmap oldvalue;
  late Bitmap savevalue;

  void reset() {
    value = initial;
    oldvalue = initial;
  }

  Future loadImage(File file) async {
    ImageProvider imageProvider = FileImage(file);

    value = await Bitmap.fromProvider(imageProvider);
    initial = value!;
    oldvalue = value!;
  }

  Future<File> buildImage(String name) async {
    final ui.Image testBuild = await value!.buildImage();
    final ByteData? datas =
        await testBuild.toByteData(format: ui.ImageByteFormat.png);

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Directory? directory = Platform.isAndroid
        ? await DownloadsPathProvider.downloadsDirectory
        : await getApplicationSupportDirectory();
    String path = directory!.path;

    File('$path/$name.png').writeAsBytesSync(datas!.buffer.asInt8List());

    return File('$path/$name.png');
  }

  Future flipHImage() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final Uint8List converted = await compute(
      flipHImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
    return;
  }

  Future flipVImage() async {
    final temp = value ?? initial;
    oldvalue = value ?? initial;
    value = null;

    final converted = await compute(
      flipVImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
    return;
  }

  Future rotateClockwiseImage() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final converted = await compute(
      rotateClockwiseImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.height, temp.width, converted);
    return;
  }

  Future rotateCounterClockwiseImage() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final converted = await compute(
      rotateCounterClockwiseImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.height, temp.width, converted);
    return;
  }

  Future rotate180Image() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final converted = await compute(
      rotate180ImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
    return;
  }

  Future contrastImage() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final Uint8List converted = await compute(
      contrastImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
    return;
  }

  Future brightnessImage() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final Uint8List converted = await compute(
      brightnessImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
    return;
  }

  Future adjustColorImage() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final Uint8List converted = await compute(
      adjustColorsImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
    return;
  }

  Future batchOperations() async {
    final temp = value!;
    oldvalue = value!;
    value = null;

    final Uint8List converted = await compute(
      batchOperationsImageIsolate,
      [temp.content, temp.width, temp.height],
    );

    value = Bitmap.fromHeadless(temp.width - 20, temp.height - 20, converted);
    return;
  }

  void checkstartsImage(bool isstart) {
    if (isstart) {
      savevalue = value!;
      value = initial;
    } else {
      value = savevalue;
    }
  }

  void deleteSteps(List<int> steps, int manystepsdelete) async {
    value = initial;

    if (steps.length >= manystepsdelete) {
      steps.length = steps.length - manystepsdelete;
    } else {
      steps.length = 0;
    }
    for (var element in steps) {
      switch (element) {
        case 1:
          await flipHImage();
          break;
        case 2:
          await flipVImage();
          break;
        case 3:
          await rotateClockwiseImage();
          break;
        case 4:
          await rotateCounterClockwiseImage();
          break;
        case 5:
          await rotate180Image();
          break;
        case 6:
          await contrastImage();
          break;
        case 7:
          await brightnessImage();
          break;
        case 8:
          await adjustColorImage();
          break;
        case 9:
          await batchOperations();
          break;
      }
    }
  }
}
