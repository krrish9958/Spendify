import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static bool _isDark = false;

  bool get isDark => _isDark;

  static Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? false;
  }

  Future<void> toggleTheme(bool value) async {
    _isDark = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
  }
}
