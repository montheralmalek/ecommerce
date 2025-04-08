import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
import '../constants/app_colors.dart';

class AppTheme {
  ///--------------------------------------
  ///--- Light Theme ---------------------
  static lightTheme(Locale? locale) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        onPrimary: AppColors.onPrimary,
        surface: AppColors.background,
        onSurface: AppColors.onBackground,
      ),
      fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          // color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          // color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          // color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(),
        bodySmall: TextStyle(),
        bodyMedium: TextStyle(),
        labelLarge: TextStyle(), //button
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.onSecondary,
        color: AppColors.secondary,
      ),
      useMaterial3: true,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(),
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.primary,
        elevation: 9,
        iconSize: 32,
      ),
    );
  }

  ///--------------------------------------
  ///--- Dark Theme ---------------------
  static darkTheme(Locale? locale) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        // brightness: Brightness.dark,
        surface: AppColors.backgroundDark,
        onSurface: AppColors.onBackgroundDark,
        // seedColor: AppColors.primaryDark,
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        onPrimary: AppColors.onPrimaryDark,
      ),
      // scaffoldBackgroundColor: AppColors.secondaryDark,
      fontFamily: locale?.languageCode == 'ar' ? 'Cairo' : 'Khand',

      appBarTheme: AppBarTheme(
        foregroundColor: AppColors.onBackgroundDark,
        color: AppColors.backgroundDark.withBlue(20),
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
    );
  }

  ///---------------------------------------------
  ///---- Pdf theme data -------------------------
  // static Future<pw.ThemeData> pdfThemeData(Locale? locale) async {
  //   final fontarR = pw.Font.ttf(
  //       await rootBundle.load('assets/fonts/Cairo/static/Cairo-Regular.ttf'));
  //   final fontArB = pw.Font.ttf(
  //       await rootBundle.load('assets/fonts/Cairo/static/Cairo-Bold.ttf'));
  //   final fontEnR = pw.Font.ttf(
  //       await rootBundle.load('assets/fonts/Khand/Khand-Regular.ttf'));
  //   final fontEnB =
  //       pw.Font.ttf(await rootBundle.load('assets/fonts/Khand/Khand-Bold.ttf'));
  //   final arPdfTheme = pw.ThemeData.withFont(base: fontarR, bold: fontArB);
  //   final enPdfTheme = pw.ThemeData.withFont(
  //       base: fontEnR, bold: fontEnB, fontFallback: [fontArB, fontarR]);
  //   return locale?.languageCode == 'ar' ? arPdfTheme : enPdfTheme;
  // }
}
