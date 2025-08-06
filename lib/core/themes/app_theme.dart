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
      // scaffoldBackgroundColor: AppColors.secondaryDark,
      fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',

      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.secondaryDark,
        color: AppColors.onSecondaryDark,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(),
        foregroundColor: AppColors.onPrimaryDark,
        backgroundColor: AppColors.primaryDark,
        elevation: 9,
        iconSize: 32,
      ),
      cardTheme: CardTheme(
        color: AppColors.secondaryDark.withValues(alpha: 0.1),
      ),
      textTheme: const TextTheme(),
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
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.primary,
        elevation: 9,
        iconSize: 32,
      ),
      textTheme: const TextTheme(),
    );
  }
}

abstract final class _CupertinoTheme {
  static CupertinoThemeData darkTheme({Locale? locale}) {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      primaryContrastingColor: AppColors.onPrimaryDark,
      barBackgroundColor: AppColors.onPrimaryDark,
      scaffoldBackgroundColor: AppColors.surfaceDark,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.primaryDark,
        navTitleTextStyle: TextStyle(
          inherit: false,
          color: AppColors.primaryDark,
        ),
      ),
    );
    // return MaterialBasedCupertinoThemeData(
    //   materialTheme: _MaterialTheme.darkTheme(),
    // );
  }

  static CupertinoThemeData lightTheme({Locale? locale}) {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      primaryContrastingColor: AppColors.onPrimary,
      barBackgroundColor: AppColors.secondary,
      scaffoldBackgroundColor: AppColors.surface,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.primary,
        navTitleTextStyle: TextStyle(inherit: false, color: AppColors.primary),
      ),
    );
  }
}
