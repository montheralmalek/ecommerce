import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xff21323c);

  static const Color onPrimary = Color(0xfffaefef);
  // static const Color secondary = Color.fromARGB(255, 113, 167, 255);
  // static const Color onSecondary = Color(0xff101222);
  static const Color surface = Color(0xfffaefef);
  static const Color onSurface = Color(0xff101222);
  static const error = Color(0xFFE74C3C);
  static const onError = surface;

  //

  // static const Color primaryDark = Color.fromARGB(255, 158, 189, 251); // Orange
  // static const Color onPrimaryDark = surfaceDark;
  // static const Color secondaryDark = secondary;
  // static const Color onSecondaryDark = onSecondary;
  // static const Color surfaceDark = onSurface;
  // static const Color onSurfaceDark = surface;
  // static const errorDark = Color.fromARGB(255, 255, 87, 87);
  // static const onErrorDark = onError;
  //
  static get lightColorScheme => ColorScheme.fromSeed(
    seedColor: primary,

    brightness: Brightness.light,
    // primary: primary,
    // onPrimary: onPrimary,
    // secondary: secondary,

    // onSecondary: onSecondary,
    surface: surface,
    onSurface: onSurface,
    // error: error,
    // onError: onError,
  );
  //
  static get darkColorScheme => ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.dark,
    // primary: primaryDark,
    // onPrimary: onPrimaryDark,
    // secondary: secondaryDark,
    // onSecondary: onSecondary,
    // surface: surfaceDark,
    // onSurface: onSurfaceDark,
    // error: errorDark,
    // onError: onErrorDark,
  );
}
