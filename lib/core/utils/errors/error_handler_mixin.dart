// lib/core/error/error_handler_mixin.dart

import 'package:flutter/widgets.dart';

import 'error_handler.dart';

mixin ErrorHandlerMixin {
  Future<T> handleError<T>(
    Future<T> Function() computation, {
    Function(Object error)? onError,
    bool showErrorMessage = true,
  }) async {
    try {
      return await computation();
    } catch (error, stackTrace) {
      ErrorHandler.handleError(error, stackTrace);

      // if (showErrorMessage && ErrorHandler.shouldShowErrorUI(error)) {
      //   _showErrorSnackbar(ErrorHandler.getErrorMessage(error));
      // }

      onError?.call(error);
      rethrow;
    }
  }

  // void _showErrorSnackbar(String message) {
  //   // You'll need to access ScaffoldMessenger in your widget
  //   // This is a simplified version - implement based on your app structure
  //   ScaffoldMessenger.of(getContext()).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: Colors.red,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  // Override this in your widget
  BuildContext getContext();
}
