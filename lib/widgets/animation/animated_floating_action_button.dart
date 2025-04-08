import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  const AnimatedFloatingActionButton({super.key, required this.actions});
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    Get.put(_AnimatedFloatingActionButtonController());
    return GetBuilder<_AnimatedFloatingActionButtonController>(
      builder: (controller) {
        return AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeTransition(
                      sizeFactor: controller.sizeController,
                      axisAlignment: -1.0,
                      // axis: Axis.horizontal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          ///------ items -----------------
                          children: actions,
                        ),
                      ),
                    ),
                  ],
                ),

                ///--------------- FloatingActionButton ------------------------
                const Gap(10),
                FloatingActionButton(
                  onPressed: controller.toggleButtons,
                  child: Transform.rotate(
                    angle: controller.rotateController.value,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AnimatedFloatingActionButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeController;
  late Animation<double> rotateController;
  late bool isButtonsOpened;
  @override
  void onInit() {
    isButtonsOpened = false;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    sizeController = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    rotateController = Tween<double>(
      begin: 0.0,
      end: pi / 4,
    ).chain(CurveTween(curve: Curves.linear)).animate(animationController);
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggleButtons() {
    isButtonsOpened
        ? animationController.reverse()
        : animationController.forward();
    isButtonsOpened = !isButtonsOpened;
    // update();
  }
}
