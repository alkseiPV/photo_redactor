import 'package:bitmap/bitmap.dart';
import 'package:flutter/foundation.dart';

Future<Uint8List> flipHImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final bigBitmap = Bitmap.fromHeadless(width, height, byteData);
  final returnBitmap = bigBitmap.apply(BitmapFlip.horizontal());

  return returnBitmap.content;
}

Future<Uint8List> flipVImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap = bigBitmap.apply(BitmapFlip.vertical());

  return returnBitmap.content;
}

Future<Uint8List> rotateClockwiseImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap = bigBitmap.apply(BitmapRotate.rotateClockwise());

  return returnBitmap.content;
}

Future<Uint8List> rotateCounterClockwiseImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap =
      bigBitmap.apply(BitmapRotate.rotateCounterClockwise());

  return returnBitmap.content;
}

Future<Uint8List> rotate180ImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap = bigBitmap.apply(BitmapRotate.rotate180());

  return returnBitmap.content;
}

Future<Uint8List> contrastImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final returnBitmap = bigBitmap.apply(BitmapContrast(1.2));

  return returnBitmap.content;
}

Future<Uint8List> brightnessImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap = bigBitmap.apply(BitmapBrightness(0.1));

  return returnBitmap.content;
}

Future<Uint8List> adjustColorsImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap = bigBitmap.apply(
    BitmapAdjustColor(
      blacks: 0x00000000,
      saturation: 1.9, // 0 and 5 mid 1.0
    ),
  );

  return returnBitmap.content;
}

Future<Uint8List> batchOperationsImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];

  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);

  final Bitmap returnBitmap = bigBitmap.applyBatch([
    BitmapAdjustColor(
      saturation: 1.9,
    ),
    BitmapCrop.fromLTWH(
      left: 10,
      top: 10,
      width: width - 20,
      height: height - 20,
    ),
  ]);

  return returnBitmap.content;
}
