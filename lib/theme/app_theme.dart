import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF8B4513),
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.crimsonTextTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    );
  }

  // Medieval color palette
  static const Color darkBrown = Color(0xFF3E2723);
  static const Color gold = Color(0xFFFFD700);
  static const Color blood = Color(0xFFB71C1C);
  static const Color stone = Color(0xFF757575);
  static const Color forestGreen = Color(0xFF1B5E20);
}
