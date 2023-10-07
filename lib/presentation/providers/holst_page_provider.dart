import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_redactor/presentation/services/image%20notifier/image_value_notifier.dart';

class HolstPageProvider extends ChangeNotifier {
  ImageValueNotifier imageValueNotifier = ImageValueNotifier();
  List<int> steps = [];

  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  bool isstartImage = false;
  late File initialImage;
  bool selectedAsset = false;

  selectAsset(bool selected) {
    selectedAsset = selected;
    notifyListeners();
  }

  flipHImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.flipHImage();
      steps.add(1);
    }
  }

  flipVImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.flipVImage();
      steps.add(2);
    }
  }

  rotateClockwiseImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.rotateClockwiseImage();
      steps.add(3);
    }
  }

  rotateCounterClockwiseImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.rotateCounterClockwiseImage();
      steps.add(4);
    }
  }

  rotate180Image() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.rotate180Image();
      steps.add(5);
    }
  }

  contrastImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.contrastImage();
      steps.add(6);
    }
  }

  brightnessImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.brightnessImage();
      steps.add(7);
    }
  }

  adjustColorImage() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.adjustColorImage();
      steps.add(8);
    }
  }

  batchOperations() {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.batchOperations();
      steps.add(9);
    }
  }

  deleteSteps(int deleteSteps) {
    if (imageValueNotifier.value != null) {
      imageValueNotifier.deleteSteps(steps, deleteSteps);
    }
  }

  checkstartsImage(bool isstart) {
    if (imageValueNotifier.value != null) {
      isstartImage = isstart;
      imageValueNotifier.checkstartsImage(isstart);
    }
    notifyListeners();
  }
}
