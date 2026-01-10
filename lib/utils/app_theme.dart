// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:task_app/utils/app_colors.dart';

class AppTheme {
  // Light theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.whiteColor,
      background: const Color(0xFFF5F5F5),
      error: AppColors.redColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.blackColor87,
      onSurface: AppColors.blackColor87,
      onBackground: AppColors.blackColor87,
      onError: AppColors.whiteColor,
      primaryContainer: AppColors.primaryColor.withOpacity(0.2),
      secondaryContainer: AppColors.secondaryColor.withOpacity(0.2),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 2,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: AppColors.whiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryColor),
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Cairo',
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.secondaryColor,
      secondary: AppColors.primaryColor,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      error: const Color(0xFFCF6679),
      onPrimary: Colors.black87,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.whiteColor,
      onBackground: AppColors.whiteColor,
      onError: AppColors.blackColor,
      primaryContainer: AppColors.secondaryColor.withOpacity(0.3),
      secondaryContainer: AppColors.primaryColor.withOpacity(0.3),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      foregroundColor: AppColors.secondaryColor,
      elevation: 2,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: Colors.black87,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.secondaryColor, width: 2),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.secondaryColor),
  );
}
