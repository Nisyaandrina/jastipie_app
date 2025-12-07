import 'package:flutter/material.dart';

// Definisi Warna
class AppColors {
  static const Color primary = Color(0xFF0D47A1); // Biru tua
  static const Color accent = Color(0xFF1976D2); // Biru sedang
  static const Color background = Color(
    0xFFF5F5F5,
  ); // Abu-abu muda untuk latar belakang
  static const Color card = Colors.white;
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
}

// Skema Warna (gunakan surface & onSurface)
final ColorScheme jastipieColorScheme = const ColorScheme.light(
  primary: AppColors.primary,
  secondary: AppColors.accent,
  surface: AppColors.card,
  error: AppColors.error,
  onPrimary: AppColors.textLight,
  onSecondary: AppColors.textLight,
  onSurface: AppColors.textDark,
  brightness: Brightness.light,
);

// Definisi Tema Aplikasi
final ThemeData appTheme = ThemeData(
  colorScheme: jastipieColorScheme,

  scaffoldBackgroundColor: AppColors.background,
  useMaterial3: true,

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textLight,
    elevation: 0,
    centerTitle: true,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.textLight,
      backgroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.card,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.accent, width: 2.0),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 12.0,
    ),
    // Bungkus Color dengan TextStyle
    hintStyle: TextStyle(color: AppColors.textDark.withValues(alpha: 0.6)),
  ),

  // Gunakan CardThemeData
  cardTheme: const CardThemeData(
    color: AppColors.card,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: AppColors.textDark),
    bodySmall: TextStyle(color: AppColors.textDark),
  ),
);
