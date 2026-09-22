import 'package:flutter/material.dart';

class AppTheme {
  static const bg = Color(0xFF0E1117);
  static const surface = Color(0xFF171B24);
  static const accent = Color(0xFF3ED598);
  static const accentSecondary = Color(0xFF4C8DFF);
  static const textPrimary = Color(0xFFEDEFF3);
  static const textSecondary = Color(0xFF8B93A5);

  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accentSecondary,
        surface: surface,
      ),
      cardColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: textPrimary,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: textPrimary),
        bodySmall: TextStyle(color: textSecondary),
        titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      useMaterial3: true,
    );
  }
}
