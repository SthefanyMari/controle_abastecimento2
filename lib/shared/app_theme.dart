import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      primaryColor: const Color(0xFF0D1B2A),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D1B2A),
        primary: const Color(0xFF0D1B2A),
        secondary: const Color(0xFFFFD700),
        background: const Color(0xFFF5F5F5),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF0D1B2A)),
        bodyMedium: TextStyle(color: Color(0xFF0D1B2A)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
    );
  }
}
