import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      primary: Color(0xFFB39DDB),
      secondary: Color(0xFF9575CD),
      background: Color(0xFFF8F6FC),
    ),

    scaffoldBackgroundColor: const Color(0xFFF8F6FC),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFB39DDB),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF7E57C2),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 48),
      ),
    ),

    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),

    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Color(0xFF2E2E2E),
      ),
      bodyMedium: const TextStyle(color: Color(0xFF555555)),
    ),
  );
}
