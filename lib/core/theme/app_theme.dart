import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- NEW PROFESSIONAL COLOR PALETTE (Inspired by your reference) ---
  static const Color scaffoldColor = Color(0xFFF8F9FA);    // Clean Off-White
  static const Color cardColor = Colors.white;
  static const Color accentColor = Color(0xFF20C997);      // Vibrant Teal
  static const Color primaryTextColor = Color(0xFF212529);    // Dark Slate (not pure black)
  static const Color secondaryTextColor = Color(0xFF6C757D); // Muted Grey
  static const Color incomeColor = Color(0xFF28A745);      // Professional Green
  static const Color expenseColor = Color(0xFFDC3545);     // Professional Red
  static final Color shadowColor = Colors.grey.withOpacity(0.1);

  // --- REFINED LIGHT THEME DATA ---
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: accentColor,
    scaffoldBackgroundColor: scaffoldColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    
    // --- App Bar Theme ---
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldColor, // Match background for a seamless look
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: primaryTextColor),
      titleTextStyle: TextStyle(
        color: primaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    // --- Card Theme ---
    cardTheme: CardThemeData(
      elevation: 0, // A flatter look matches the logo style
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    // --- Text Theme ---
    textTheme: TextTheme(
      bodyLarge: const TextStyle(color: primaryTextColor),
      bodyMedium: const TextStyle(color: secondaryTextColor),
      headlineMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        fontSize: 32,
      ),
      titleLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        fontSize: 18,
      ),
    ),

    // --- Input Decoration Theme ---
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // White fields on the off-white background
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
      labelStyle: const TextStyle(color: secondaryTextColor),
    ),

    // --- Button Themes ---
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.white, // Text on button
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedColor: Colors.white,
      color: primaryTextColor,
      fillColor: accentColor,
      borderRadius: BorderRadius.circular(12),
      constraints: const BoxConstraints(minHeight: 40.0),
      selectedBorderColor: accentColor,
      borderColor: Colors.grey.shade400,
    ),
    
    // --- Main Color Scheme ---
    colorScheme: ColorScheme.light(
      primary: accentColor,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.white,
      surface: cardColor,
      onSurface: primaryTextColor,
      background: scaffoldColor,
      onBackground: primaryTextColor,
      error: expenseColor,
      onError: Colors.white,
    ),
  );
}