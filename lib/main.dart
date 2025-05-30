import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart'
    show PlatformProvider, PlatformTheme, PlatformApp;
import 'package:logging/logging.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/core/config/providers.dart';
import 'package:store/data/repositories/auth_repository.dart';
import 'package:store/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:store/routing/router.dart';
import 'package:store/core/themes/app_theme.dart';
import 'package:store/widgets/widgets.dart';

void main() async {
  debugPrint('Starting application');
  // Set up logging
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
      );
    });
    Logger.root.info('Debug mode enabled, logging at ALL level');
  } else if (kProfileMode) {
    Logger.root.level = Level.INFO; // Reduce logging in profile mode
    Logger.root.onRecord.listen((record) {
      debugPrint(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
      );
    });
    Logger.root.info('Profile mode enabled, logging at INFO level');
  } else {
    Logger.root.level = Level.WARNING; // Reduce logging in production
  }
  WidgetsFlutterBinding.ensureInitialized();

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

///
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static final _log = Logger('MainApp');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _log.info('MainApp build');

    return MultiBlocProvider(
      providers: providers,

      child: PlatformProvider(
        builder: (context) {
          return PlatformTheme(
            // themeMode: context.read<SettingCubit>().themeMode,
            materialLightTheme: AppTheme.materialLightTheme,
            materialDarkTheme: AppTheme.materialDarkTheme,
            cupertinoLightTheme: AppTheme.cupertinoLightTheme,
            cupertinoDarkTheme: AppTheme.cupertinoDarkTheme,
            onThemeModeChanged: (mode) {
              debugPrint('Theme mode changed to: $mode');
              context.read<SettingCubit>().setThemeMode(mode);
            },
            builder:
                (context) => PlatformApp.router(
                  title: 'Store App',
                  routerConfig: router(getIt<AuthRepository>()),
                  localizationsDelegates: [
                    DefaultCupertinoLocalizations.delegate,
                    DefaultMaterialLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', 'ar'), // add other locales if needed
                  ],
                ),
          );
        },
      ),
      //   },
      // ),
    );
  }
}
