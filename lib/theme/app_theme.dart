import 'package:flutter/material.dart';

class AppColors {
  static final primary = Colors.blue[800];
  static final secondary = Colors.blue[50];
  static const background = Colors.white;
  static final textPrimary = Colors.grey[800];
  static final textSecondary = Colors.grey[600];
}

class AppTheme {
  static ThemeData themeData = ThemeData(
    cardColor: Colors.white,
    cardTheme: const CardThemeData(
      color: Colors.white,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue[100], // Highlight color for selected text
      cursorColor: Colors.black, // Cursor color
      // selectionHandleColor: Colors.red, // Handle color
    ),
  );

}