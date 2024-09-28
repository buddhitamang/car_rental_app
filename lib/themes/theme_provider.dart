import 'package:car_rental_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  final String _themePrefKey = 'theme_mode';

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveTheme(); // Save theme when it changes
  }

  bool get isDarkMode => _themeData == darkMode;

  void toggleTheme(bool isDarkMode) {
    themeData = isDarkMode ? darkMode : lightMode;
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(_themePrefKey) ?? false;
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefKey, _themeData == darkMode);
  }
}
