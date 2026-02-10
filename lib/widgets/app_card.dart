import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF6C5CE7);
  static const Color background = Color(0xFFF5F6FA);
  static const Color card = Colors.white;
  static const Color textPrimary = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF8E8E93);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: textPrimary)),
  );
}
