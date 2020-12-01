import 'package:flutter/material.dart';

class ThemeFactory {
  ThemeFactory._();

  static ThemeData theme(bool isDark) {
    return isDark ? getDarkTheme() : getLightTheme();
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark, colorScheme: ColorScheme.dark());
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
//        bodyText1: TextStyle(fontSize: 16, color: Colors.white),
          ),
      scaffoldBackgroundColor: Colors.indigoAccent,
      colorScheme: ColorScheme.light(),
    );
  }
}
