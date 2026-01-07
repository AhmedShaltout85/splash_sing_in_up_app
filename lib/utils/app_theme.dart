import 'package:flutter/material.dart';
import 'package:task_app/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightGrayColor,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.lightGrayColor,
      iconTheme: IconThemeData(color: AppColors.customBlueColor),
      actionsIconTheme: IconThemeData(color: AppColors.customBlueColor),
      titleTextStyle: TextStyle(
        color: AppColors.customBlueColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    ),

    drawerTheme: DrawerThemeData(backgroundColor: AppColors.pinkColor),

    listTileTheme: ListTileThemeData(
      textColor: AppColors.whiteColor,
      iconColor: AppColors.whiteColor,
    ),

    primaryColor: AppColors.customBlueColor,

    colorScheme: ColorScheme.light(
      primary: AppColors.customBlueColor,
      secondary: AppColors.pinkColor,
      surface: AppColors.whiteColor,
      error: Colors.red,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.customBlueColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.blueColor),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
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
        borderSide: BorderSide(color: AppColors.blueColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.whiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.customBlueColor,
      foregroundColor: AppColors.whiteColor,
    ),

    iconTheme: IconThemeData(color: AppColors.blueColor),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.customBlueColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.customBlueColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.customBlueColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
      bodySmall: TextStyle(color: Colors.black54, fontSize: 12),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primaryColor,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      actionsIconTheme: IconThemeData(color: AppColors.whiteColor),
      titleTextStyle: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    ),

    drawerTheme: DrawerThemeData(backgroundColor: AppColors.primaryColor),

    listTileTheme: ListTileThemeData(
      textColor: AppColors.whiteColor,
      iconColor: AppColors.whiteColor,
    ),

    primaryColor: AppColors.secondaryColor,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.blueColor,
      surface: Colors.grey[850]!,
      error: Colors.redAccent,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondaryColor),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
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
        borderSide: BorderSide(color: AppColors.blueColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.grey[850],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.whiteColor,
    ),

    iconTheme: IconThemeData(color: AppColors.whiteColor),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
      bodySmall: TextStyle(color: Colors.white54, fontSize: 12),
    ),
  );
}
