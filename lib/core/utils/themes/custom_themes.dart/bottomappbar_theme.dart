import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class DBottomAppBarTheme {
  DBottomAppBarTheme._(); // Private constructor

  // Light BottomAppBarThemeData
  
  static BottomAppBarTheme lightBottomAppBarTheme = BottomAppBarTheme(
    color: AppColors.light().backgroundColor,
    elevation: 8,
    shadowColor: AppColors.light().textColor,
    shape: const CircularNotchedRectangle(),
  );

  // Dark BottomAppBarThemeData
  static BottomAppBarTheme darkBottomAppBarTheme = BottomAppBarTheme(
    color: AppColors.dark().backgroundColor,
    elevation: 8,
    shadowColor: AppColors.dark().textColor,
    surfaceTintColor: AppColors.dark().textColor,
    shape: const CircularNotchedRectangle(),
  );
}