import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color.fromARGB(255, 255, 149, 0);
  static const Color onPrimary = Color(0xff101222);
  static const Color secondary = Color(0xff213555);
  static const Color onSecondary = Color(0xfffaefef);
  static const Color surface = Color(0xfffaefef);
  static const Color onSurface = Color(0xff101222);
  static const error = Color(0xFFE74C3C);
  static const onError = surface;

  //

  static const Color primaryDark = Color.fromARGB(255, 158, 189, 251); // Orange
  static const Color onPrimaryDark = surfaceDark;
  static const Color secondaryDark = primary;
  static const Color onSecondaryDark = surfaceDark;
  static const Color surfaceDark = onSurface;
  static const Color onSurfaceDark = surface;
  static const errorDark = Color.fromARGB(255, 255, 87, 87);
  static const onErrorDark = onError;
  //
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,

    onSecondary: onSecondary,
    surface: surface,
    onSurface: onSurface,
    error: error,
    onError: onError,
  );
  //
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    onPrimary: onPrimaryDark,
    secondary: secondaryDark,
    onSecondary: onSecondary,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
    error: errorDark,
    onError: onErrorDark,
  );
}
