import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/core/services/dependency_injection.dart';
import 'package:store/store_app.dart';
import 'package:store/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initialServices();
  await initializeDependencies();
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      return CustomErrorWidget(message: details.exceptionAsString());
    }
    return const CustomErrorWidget(message: 'error');
  };
  runApp(const StoreApp());
}
