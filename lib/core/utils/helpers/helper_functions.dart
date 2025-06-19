import 'package:flutter/material.dart';

class HelperFunctions {
  /// Returns a light or dark color based on the given color.
  /// If the color is light, it returns black; if dark, it returns white.
  static Color getColorOn(Color color) {
    final double luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Returns avrage of a list of numbers.
  static double calculateAverage(List<double> numbers) {
    if (numbers.isEmpty) return 0.0;
    final sum = numbers.reduce((a, b) => a + b);
    return sum / numbers.length;
  }
}
