import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/presentation/platforms/platform_service.dart';

class IosService implements PlatformService {
  const IosService();
  @override
  Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? content,
    bool barrierDismissible = true,
  }) {
    return showCupertinoSheet<T>(
      context: context,
      pageBuilder: (context) => child,
    );
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
    throw UnimplementedError();
  }

  @override
  Future<T?> showDialog<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? content,
    bool barrierDismissible = true,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(title ?? ''),
            content: child,
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
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
  Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    String? content,
  }) {
    throw UnimplementedError();
  }
}
