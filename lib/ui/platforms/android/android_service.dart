import 'package:flutter/material.dart';
import 'package:store/ui/platforms/platform_service.dart';

class AndroidService implements PlatformService {
  const AndroidService();
  @override
  Future<T?> showDialog<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? content,
    bool barrierDismissible = true,
  }) {
    return showAdaptiveDialog<T>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title ?? ''),
            content: child,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? content,
    bool barrierDismissible = true,
  }) {
    return showBottomSheet<T>(
      context: context,
      child: BottomSheet(onClosing: () {}, builder: (context) => child),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  void showSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), duration: duration));
  }

  @override
  Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    String? content,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      title: title,
      content: content,
    );
  }

  @override
  Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    String? content,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      title: title,
      content: content,
    );
  }
}
