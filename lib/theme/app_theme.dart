import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00A8E8); // Azul claro vibrante
  static const Color primaryDark = Color(0xFF007EA7);
  static const Color secondaryColor = Color(0xFF003459);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(
    0xFFF4FAFF,
  ); // Fundo bem claro levemente azulado
  static const Color textPrimary = Color(0xFF1E2D3D);
  static const Color textSecondary = Color(0xFF5A7184);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 56,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.poppins(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 42,
          height: 1.2,
        ),
        headlineLarge: GoogleFonts.poppins(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 32,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: textSecondary,
          fontSize: 18,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: textSecondary,
          fontSize: 16,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightGradient = LinearGradient(
    colors: [surfaceColor, backgroundColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
