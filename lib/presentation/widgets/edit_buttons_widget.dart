import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditButtonsWidget extends StatelessWidget {
  const EditButtonsWidget({
    Key? key,
    required this.flipHImage,
    required this.rotateClockwiseImage,
    required this.rotateCounterClockwiseImage,
    required this.contrastImage,
    required this.brightnessImage,
    required this.adjustColorImage,
    required this.batchOperations,
  }) : super(key: key);

  final VoidCallback flipHImage;

  final VoidCallback rotateClockwiseImage;
  final VoidCallback rotateCounterClockwiseImage;

  final VoidCallback contrastImage;
  final VoidCallback brightnessImage;
  final VoidCallback adjustColorImage;
  final VoidCallback batchOperations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 52,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 24.w,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(35, 50),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()),
                  onPressed: flipHImage,
                  child: Image.asset(
                    'assets/png/flip_icon.png',
                    width: 55.w,
                    height: 70.h,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(35, 50),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()),
                  onPressed: contrastImage,
                  child: Image.asset(
                    'assets/png/contrast_icon.png',
                    width: 55.w,
                    height: 70.h,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(35, 50),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()),
                  onPressed: brightnessImage,
                  child: Image.asset(
                    'assets/png/brightness_icon.png',
                    width: 55.w,
                    height: 70.h,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(35, 50),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()),
                  onPressed: adjustColorImage,
                  child: Image.asset(
                    'assets/png/opacity_icon.png',
                    width: 55.w,
                    height: 70.h,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(35, 50),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()),
                  onPressed: rotateClockwiseImage,
                  child: Image.asset(
                    'assets/png/rotate_left_icon.png',
                    width: 55.w,
                    height: 70.h,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(35, 50),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()),
                  onPressed: rotateCounterClockwiseImage,
                  child: Image.asset(
                    'assets/png/rotate_right_icon.png',
                    width: 55.w,
                    height: 70.h,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
