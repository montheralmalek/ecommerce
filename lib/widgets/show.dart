import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'animation/animated_rising.dart';

class Show<T> {
  static Future snackBar() async {
    Get.showSnackbar(
      const GetSnackBar(
        title: 'mmmmmm',
        message: 'ssssssssssss',
        snackPosition: SnackPosition.TOP,
        leftBarIndicatorColor: Colors.amber,
        duration: Duration(seconds: 2),
        overlayBlur: 0.5,
        overlayColor: Colors.black45,
        dismissDirection: DismissDirection.horizontal,
        maxWidth: 350,
        snackStyle: SnackStyle.FLOATING,
      ),
    );
  }

  static Future errorDialog(
    String message, {
    Duration closeAfter = const Duration(seconds: 2),
  }) async {
    final dialog = Get.generalDialog(
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => AnimatedTransition(
            animation: animation,
            child: _CustomDialog(
              message: message,
              title: 'Error',
              icon: Icons.error_outline,
              iconColor: Theme.of(context).colorScheme.error,
            ),
          ),
      transitionDuration: const Duration(milliseconds: 500),
    );

    Future.delayed(closeAfter, () {
      Get.back();
    });

    return await dialog;
  }

  static Future successDialog(
    String message, {
    Duration closeAfter = const Duration(seconds: 2),
  }) async {
    final dialog = Get.generalDialog(
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => AnimatedTransition(
            animation: animation,
            child: _CustomDialog(
              message: message,
              title: 'Success',
              icon: Icons.check_circle_outline,
              iconColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
      transitionDuration: const Duration(milliseconds: 400),
    );

    Future.delayed(closeAfter, () {
      Get.back();
    });

    return await dialog;
  }

  static Future<bool> alertDialog(
    String message, {
    String textConfirm = 'Ok',
    String textCancel = 'Cancel',
  }) async {
    final result = await Get.defaultDialog<bool>(
      title: 'Alert',
      middleText: message,
      textConfirm: textConfirm,
      textCancel: textCancel,
      onConfirm: () {
        Get.back(result: true);
      },
      barrierDismissible: false,
    );

    return result ?? false;
  }
}

class _CustomDialog extends StatelessWidget {
  const _CustomDialog({
    required this.message,
    required this.title,
    this.icon = Icons.info_outline,
    this.iconColor,
    this.barIndicatorWidth = 1,
    this.maxWidth = 300,
    this.barIndicatorColor,
  });
  final String message, title;
  final IconData? icon;
  final Color? iconColor;
  final double barIndicatorWidth, maxWidth;
  final Color? barIndicatorColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: maxWidth,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          clipBehavior: Clip.hardEdge,
          color: Theme.of(context).colorScheme.surface,
          child: Container(
            decoration: BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(
                  width: barIndicatorWidth,
                  color:
                      barIndicatorColor ??
                      iconColor ??
                      Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            child: ListTile(
              iconColor: iconColor,
              leading: AnimatedRising(
                duration: const Duration(milliseconds: 500),
                waitDuration: const Duration(milliseconds: 400),
                scaleCurve: Curves.bounceOut,
                opacityBegin: 1,
                child: Icon(icon, size: 50),
              ),
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
