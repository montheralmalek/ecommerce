// lib/core/error/error_handler.dart

import 'dart:async' show Zone;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/widgets/custom_error_widget.dart';

class ErrorHandler {
  static void setupErrorHandling() {
    // Handle errors from the Flutter framework
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    // Handle Dart errors
    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrint('----------  Error dispatcher widget');
      _reportError(error, stack);
      return true;
    };
    // Build error widget
    ErrorWidget.builder = (FlutterErrorDetails details) {
      debugPrint('---------- Build error widget');
      if (kDebugMode) {
        return GlobalErrorWidget(message: details.exceptionAsString());
      }
      return const CustomErrorWidget(message: 'An unexpected error occurred.');
    };
  }

  static void handleError(Object error, StackTrace stackTrace) {
    _reportError(error, stackTrace);
  }

  static Future<void> _reportError(Object error, StackTrace stackTrace) async {
    if (kDebugMode) {
      debugPrint('Error: $error');
      debugPrint('Stack Trace: $stackTrace');
    } else {
      // In production, report to your error tracking service
      await _reportToCrashlytics(error, stackTrace);
    }
  }

  static Future<void> _reportToCrashlytics(
    Object error,
    StackTrace stackTrace,
  ) async {
    // TODO: Integrate with your crash reporting service
    // Example: Firebase Crashlytics, Sentry, etc.
    /*
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'non-fatal error',
    );
    */
  }

  // static String getErrorMessage(Object error) {
  //   if (error is AppException) {
  //     return error.message;
  //   } else if (error is SocketException) {
  //     return 'No internet connection';
  //   } else if (error is HttpException) {
  //     return 'Network error occurred';
  //   } else if (error is FormatException) {
  //     return 'Data format error';
  //   } else {
  //     return 'An unexpected error occurred';
  //   }
  // }

  // static bool isNetworkError(Object error) {
  //   return error is SocketException ||
  //       error is HttpException ||
  //       error is NetworkException ||
  //       error is TimeoutException;
  // }

  // static bool shouldShowErrorUI(Object error) {
  //   // Don't show UI for certain errors in production
  //   if (!kDebugMode) {
  //     return error is! FormatException; // Example: Don't show UI for format errors
  //   }
  //   return true;
  // }
}
