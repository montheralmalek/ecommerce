import 'package:flutter/material.dart';

extension ThemeModeExtensions on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;
  bool get isSystem => this == ThemeMode.system;
}
