import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/core/config/providers.dart';
import 'package:store/main_platform_app.dart';
import 'package:store/core/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('Starting application');
  // Set up logging
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    // Logger.root.onRecord.listen((record) {
    //   debugPrint(
    //     '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
    //   );
    // });
    Logger.root.info('Debug mode enabled, logging at ALL level');
  } else if (kProfileMode) {
    Logger.root.level = Level.INFO; // Reduce logging in profile mode
    // Logger.root.onRecord.listen((record) {
    //   debugPrint(
    //     '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
    //   );
    // });
    Logger.root.info('Profile mode enabled, logging at INFO level');
  } else {
    Logger.root.level = Level.WARNING; // Reduce logging in production
  }

  // Initialize dependencies and other tasks
  await Future.microtask(() async {
    debugPrint('Initializing dependencies');
    await initializeDependencies();
    debugPrint('Dependencies initialized');
  });

  // Custom error handling
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
    // Optionally log errors to a monitoring service
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      return CustomErrorWidget(message: details.exceptionAsString());
    }
    return const CustomErrorWidget(message: 'An unexpected error occurred.');
  };

  runApp(const MainApp());
}

/// Main application widget that sets up the theme and routing.
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static final _log = Logger('MainApp');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _log.info('MainApp build');

    return MultiBlocProvider(
      providers: providers,

      child: const MainPlatformApp(),
    );
  }
}
