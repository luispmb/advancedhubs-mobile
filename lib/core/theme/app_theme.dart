import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Cores do design CasaGPT (Figma).
class AppColors {
  AppColors._();

  static const Color darkBlue800 = Color(0xFF1D1F42);
  static const Color darkBlue600 = Color(0xFF262855);
  static const Color purple800 = Color(0xFF413574);
  static const Color purple600 = Color(0xFF544596);
  static const Color purple400 = Color(0xFFAEAAC7);
  static const Color purple200 = Color(0xFFE7E6EE);
  static const Color purple100 = Color(0xFFF3F3F7);
  static const Color gray1000 = Color(0xFF6E6B6D);
  static const Color gray700 = Color(0xFFDBD6D9);
  static const Color gray900 = Color(0xFF9B979A);
  static const Color gray600 = Color(0xFFF5EFF3);
  static const Color darkBlue200 = Color(0xFFE5E5E7);
  static const Color infoBoxBg = Color(0xFFECF8FD);
  static const Color infoBoxBorder = Color(0xFF78A9D6);
  static const Color teal600 = Color(0xFF6AC4CC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color neutralLightGrey = Color(0xFFF5F5F5);
  static const Color roiGreen = Color(0xFF059669);
  static const Color roiGreenBorder = Color(0xFF34D399);
  static const Color roiGreenBg = Color(0xFFECFDF5);
  static const Color warningBg = Color(0xFFFFF8E6);
  static const Color warningBorder = Color(0xFFE6B84D);
  static const Color successCardBg = Color(0xFFE8F5E9);
  static const Color successCardBorder = Color(0xFF81C784);
  static const Color roiRed = Color(0xFFDC2626);
}

/// Tema global da aplicação CasaGPT.
/// Cores e tipografia alinhadas ao Figma (CasaGPT - Core Product 2026).
class AppTheme {
  AppTheme._();

  /// Tema claro (light) — base para a aplicação.
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.purple600,
        onPrimary: AppColors.white,
        secondary: AppColors.teal600,
        onSecondary: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.darkBlue800,
        surfaceContainerHighest: AppColors.purple100,
        outline: AppColors.purple400,
        outlineVariant: AppColors.gray700,
        onSurfaceVariant: AppColors.gray900,
      ),
      scaffoldBackgroundColor: AppColors.purple100,
      fontFamily: 'Montserrat',
      textTheme: _buildTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkBlue800,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.darkBlue200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.darkBlue200),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple600,
          foregroundColor: AppColors.white,
          elevation: 0,
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.darkBlue800,
        height: 1.0,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: AppColors.darkBlue800,
        height: 1.0,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.darkBlue800,
        height: 1.3,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.gray900,
        height: 1.3,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBlue800,
        height: 1.3,
      ),
    );
  }

  /// Tema escuro (opcional para fases posteriores).
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple600,
        secondary: AppColors.teal600,
      ),
      fontFamily: 'Montserrat',
      textTheme: _buildTextTheme().apply(bodyColor: AppColors.white),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
