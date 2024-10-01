import 'package:flutter/material.dart';


class AppColors {
  static const Color _actionColor = Color.fromARGB(255, 84, 58, 234);
  //static const Color _actionColor =  Colors.orange;
  static final AppColors _lightInstance = AppColors._internalLight();
  static final AppColors _darkInstance = AppColors._internalDark();

  final Color textColor;
  final Color backgroundColor;
  final Color contentBoxColor;
  final Color iconColor;
  final Color primaryColor;
  final Color accentColor;
  final Color buttonColor;
  final Color drawerColor;
  final Color popupBackgroundColor;

  AppColors._internalLight()
      : textColor = Colors.black,
        backgroundColor = Colors.grey.shade200,
        contentBoxColor = Colors.white,
        iconColor = Colors.black,
        primaryColor = _actionColor,
        accentColor = _actionColor,
        buttonColor = _actionColor,
        drawerColor = Colors.white,
        popupBackgroundColor = Colors.grey[200]!;

  AppColors._internalDark()
      : textColor = Colors.white,
        contentBoxColor = Colors.black,
        backgroundColor = Colors.grey.shade900,
        iconColor = Colors.white,
        primaryColor = _actionColor,
        accentColor = _actionColor,
        buttonColor = _actionColor,
        drawerColor = Colors.black,
        popupBackgroundColor = Colors.grey[850]!;


  factory AppColors.light() {
    return _lightInstance;
  }

  factory AppColors.dark() {
    return _darkInstance;
  }

  factory AppColors.context(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark ? _darkInstance : _lightInstance;
  }
}