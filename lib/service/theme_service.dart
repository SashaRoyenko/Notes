import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/factory/theme_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _sharedPreferences;
  bool _isDarkTheme;
  ThemeData _currentTheme;

  bool get isDarkTheme => _isDarkTheme;


  ThemeData get currentTheme => _currentTheme;

  ThemeService() {
    _isDarkTheme = true;
    _currentTheme = ThemeFactory.theme(_isDarkTheme);
    _loadFromPrefs();
  }

  changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    _currentTheme = ThemeFactory.theme(_isDarkTheme);
    _saveToPrefs();
    notifyListeners();
  }

  _initPreferences() async {
    if (_sharedPreferences == null) _sharedPreferences = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPreferences();
    _isDarkTheme = _sharedPreferences.getBool(key) ?? true;
    _currentTheme = ThemeFactory.theme(_isDarkTheme);
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPreferences();
    _sharedPreferences.setBool(key, _isDarkTheme);
  }
}
