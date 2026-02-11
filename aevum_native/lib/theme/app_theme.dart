import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF1173D4); // From screens-inventory.md
  static const Color background = Color(0xFF111827); // Tailwind gray-900
  static const Color accent = Color(0xFF8B5CF6); // Tailwind purple-500
  static const Color surface = Color(0xFF1F2937); // Tailwind gray-800

  static const Color glassSurface = Color(0x1AFFFFFF); // rgba(255, 255, 255, 0.1)
  static const Color glassBorder = Color(0x26FFFFFF); // rgba(255, 255, 255, 0.15)
  static const Color glassDarker = Color(0x33000000); // rgba(0, 0, 0, 0.2)

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surface,
        background: background,
      ),
      textTheme: GoogleFonts.manropeTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      useMaterial3: true,
    );
  }
}
