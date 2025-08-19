import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1A237E); // Indigo[900]
  static const Color secondary = Color.fromARGB(
    255,
    203,
    196,
    176,
  ); // Amber[300]
  static const Color backgroundLight = Color.fromARGB(
    255,
    178,
    183,
    220,
  ); // Indigo[700]
  static const Color backgroundDark = Color(0xFF0D1333); // Deeper Indigo

  // Text Colors
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFFFF8E1);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: AppColors.textLight,
    fontFamily: 'Poppins',
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    color: AppColors.secondary,
    fontFamily: 'Poppins',
  );

  static const TextStyle body = TextStyle(
    fontSize: 18,
    height: 1.5,
    color: AppColors.textSecondary,
    fontFamily: 'OpenSans',
  );

  static const TextStyle navItem = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.9,
    color: Colors.white,
    fontFamily: 'Poppins',
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.primary,
    fontFamily: 'Poppins', // Global font
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      bodyMedium: AppTextStyles.body,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondary,
    ),
  );
}
