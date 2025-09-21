import 'package:flutter/material.dart';

abstract class PlatformService {
  const PlatformService();

  /// Shows a platform-specific dialog
  Future<T?> showDialog<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? content,
    bool barrierDismissible = true,
  });

  /// Shows a platform-specific bottom sheet
  Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? content,
    bool barrierDismissible = true,
  });

  /// Shows a platform-specific snackbar
  void showSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  });

  /// Shows a platform-specific date picker
  Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    String? content,
  });

  /// Shows a platform-specific time picker
  Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    String? content,
  });
}
