import 'package:flutter/material.dart';

class AppTheme {
  static const Color seedColor = Colors.teal;

  static ThemeData get lightTheme {
    return _buatTema(Brightness.light);
  }

  static ThemeData get darkTheme {
    return _buatTema(Brightness.dark);
  }

  static ThemeData _buatTema(Brightness brightness) {
    final skemaWarna = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: skemaWarna,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: skemaWarna.surface,
        foregroundColor: skemaWarna.onSurface,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}