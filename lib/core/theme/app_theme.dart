import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors from Figma design
  static const Color primaryColor = Color(0xFFA0D12A); // Green color for buttons
  static const Color darkBackground = Color(0xFF0F0F16); // Dark background
  static const Color lightTextColor = Color(0xFFFFFFFF); // White text
  static const Color greyTextColor = Color(0xFFCABCE); // Grey text
  static const Color lightGreyColor = Color(0xFFF5F6F8); // Light grey
  static const Color inputBackgroundColor = Color(0x1AFFFFFF); // Semi-transparent white

  // Text styles
  static TextStyle get headingLarge => const TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 46,
        fontWeight: FontWeight.w700,
        color: lightTextColor,
        letterSpacing: -0.03 * 46,
      );

  static TextStyle get headingMedium => const TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: lightTextColor,
      );

  static TextStyle get headingSmall => const TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: lightTextColor,
        letterSpacing: -0.03 * 25,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: lightTextColor,
        letterSpacing: -0.01 * 18,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: lightTextColor,
        letterSpacing: -0.01 * 16,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: greyTextColor,
        letterSpacing: -0.01 * 14,
      );

  static TextStyle get buttonText => const TextStyle(
        fontFamily: 'Kanit',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF21242C), // Dark text on green button
        letterSpacing: -0.01 * 18,
      );

  // Theme data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: lightGreyColor,
        background: darkBackground,
        surface: darkBackground,
      ),
      textTheme: TextTheme(
        displayLarge: headingLarge,
        displayMedium: headingMedium,
        displaySmall: headingSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: buttonText,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: const Color(0xFF21242C),
          textStyle: buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 1),
        ),
        hintStyle: bodyMedium.copyWith(color: const Color(0xFF95989D)),
      ),
    );
  }
}