import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';

class DAppBarTheme {
  DAppBarTheme._(); // Private constructor

  // Light AppBarTheme
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.light().backgroundColor,
    //foregroundColor: AppColors.light().contentBoxColor,
    surfaceTintColor: AppColors.light().backgroundColor,
    elevation: 4,
    iconTheme: IconThemeData(color: AppColors.light().iconColor),
    actionsIconTheme: IconThemeData(color: AppColors.light().iconColor),
    toolbarTextStyle: TextStyle(color: AppColors.light().textColor),
    titleTextStyle: TextStyle(
      color: AppColors.light().textColor,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: false,
    toolbarHeight: kToolbarHeight,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  // Dark AppBarTheme
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.dark().backgroundColor,
    foregroundColor: AppColors.dark().textColor,
    elevation: 4,
    iconTheme: IconThemeData(color: AppColors.dark().iconColor),
    actionsIconTheme: IconThemeData(color: AppColors.dark().iconColor),
    toolbarTextStyle: TextStyle(color: AppColors.dark().textColor),
    titleTextStyle: TextStyle(
      color: AppColors.dark().textColor,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: false,
    toolbarHeight: kToolbarHeight,
    // bottom: PreferredSize(
    //   preferredSize: Size.fromHeight(kToolbarHeight),
    //   child: Container(),
    // ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static AppBarTheme getAppBarTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightAppBarTheme : darkAppBarTheme;
  }
}