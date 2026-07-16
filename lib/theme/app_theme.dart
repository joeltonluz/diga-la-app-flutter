import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData regular() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF6B8E9B),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFFD4A5A5),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFFF5F0E8),
      onSurface: Color(0xFF2C2C2C),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 18),
        bodyMedium: TextStyle(fontSize: 18),
        labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static ThemeData highContrast() {
    return regular();
  }
}
