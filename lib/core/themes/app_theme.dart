import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData materialLightTheme = _MaterialTheme.lightTheme();
  static ThemeData materialDarkTheme = _MaterialTheme.darkTheme();
  static CupertinoThemeData cupertinoLightTheme = _CupertinoTheme.lightTheme();
  static CupertinoThemeData cupertinoDarkTheme = _CupertinoTheme.darkTheme();
}

abstract final class _MaterialTheme {
  static ThemeData darkTheme({Locale? locale}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
      fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(),

        elevation: 9,
        iconSize: 32,
      ),
      // cardTheme: CardTheme(color: AppColors.surfaceDark.withAlpha(180)),
      // textTheme: const TextTheme(),
    );
  }

  static ThemeData lightTheme({Locale? locale}) {
    return ThemeData(
      platform: TargetPlatform.android,
      colorScheme: AppColors.lightColorScheme,

      fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',

      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.onPrimary,
        color: AppColors.primary,
      ),
      useMaterial3: true,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(),
        // foregroundColor: AppColors.onPrimary,
        // backgroundColor: AppColors.primary,
        elevation: 9,
        iconSize: 32,
      ),
      // textTheme: const TextTheme(),
      cardTheme: CardTheme(color: AppColors.surface.withAlpha(180)),
      // buttonTheme: const ButtonThemeData(shape: RoundedRectangleBorder()),
      // filledButtonTheme: FilledButtonThemeData(
      //   style: FilledButton.styleFrom(
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //   ),
      // ),
    );
  }
}

abstract final class _CupertinoTheme {
  // static final CupertinoThemeData _cupretinoThemeData = CupertinoThemeData(
  //   primaryColor: AppColors.primary,
  //   primaryContrastingColor: AppColors.onPrimary,
  //   textTheme: CupertinoTextThemeData(primaryColor: AppColors.onPrimary),
  // );
  static CupertinoThemeData darkTheme({Locale? locale}) {
    // return _cupretinoThemeData.copyWith(
    //   brightness: Brightness.dark,
    //   barBackgroundColor: AppColors.primary,
    //   scaffoldBackgroundColor: AppColors.primary,
    // );

    return MaterialBasedCupertinoThemeData(
      materialTheme: _MaterialTheme.darkTheme(),
    ).copyWith(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.onPrimary,
        textStyle: TextStyle(
          fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',
        ),
      ),
    );
  }

  static CupertinoThemeData lightTheme({Locale? locale}) {
    return MaterialBasedCupertinoThemeData(
      materialTheme: _MaterialTheme.lightTheme(),
    ).copyWith(
      brightness: Brightness.light,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.onSurface,
        textStyle: TextStyle(
          fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',
        ),
      ),
    );
    // return _cupretinoThemeData.copyWith(
    //   brightness: Brightness.light,
    //   barBackgroundColor: AppColors.primary,
    //   scaffoldBackgroundColor: AppColors.surface,
    // );
  }
}
