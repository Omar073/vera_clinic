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
    cardTheme: const CardTheme(
      color: Colors.white,),
  );
}