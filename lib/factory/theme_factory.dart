import 'package:flutter/material.dart';

class ThemeFactory {
  ThemeFactory._();

  static ThemeData theme(bool isDark) {
    return isDark ? getDarkTheme() : getLightTheme();
  }

  static ThemeData getDarkTheme() {
      return ThemeData.dark();
  }

  static ThemeData getLightTheme() {
    return ThemeData.light();
  }

}