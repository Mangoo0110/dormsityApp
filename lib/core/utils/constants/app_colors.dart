import 'package:flutter/material.dart';


class AppColors {
  static const Color _actionColor = Color.fromARGB(255, 238, 119, 68);//Color.fromARGB(255, 58, 64, 234);
  static const Color _secondaryActionColor = Color.fromARGB(255, 68, 71, 238);//Color.fromARGB(255, 58, 64, 234);
  //static const Color _actionColor =  Colors.orange;
  static final AppColors _lightInstance = AppColors._internalLight();
  static final AppColors _darkInstance = AppColors._internalDark();

  final Color textColor;
  final Color textGreyColor;
  final Color backgroundColor;
  final Color contentBoxColor;
  final Color contentBoxGreyColor;
  final Color iconColor;
  final Color primaryColor;
  final Color accentColor;
  final Color secondaryAccentColor;
  final Color buttonColor;
  final Color drawerColor;
  final Color fillColor; 
  final Color hintColor;
  final Color labelColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color borderColor;
  final Color popupBackgroundColor;
  final Color dividerColor;
  final Color tabBarColor;
  final Color shadowColor;

  AppColors._internalLight()
      : textColor = Colors.black,
        textGreyColor = Colors.grey.shade700,
        contentBoxColor = Colors.white,
        contentBoxGreyColor = Colors.grey.shade200,
        backgroundColor = Colors.white,
        iconColor = Colors.black,
        primaryColor = _actionColor,
        secondaryAccentColor = _secondaryActionColor,
        accentColor = _actionColor,
        buttonColor = _actionColor,
        drawerColor = Colors.white,
        fillColor = Colors.transparent,
        hintColor = Colors.grey.shade700,
        labelColor = Colors.grey.shade800,
        focusedBorderColor = Colors.black, // same as text color
        enabledBorderColor = Colors.grey.shade700,
        borderColor = Colors.grey.shade700,
        dividerColor = Colors.grey.shade200,
        popupBackgroundColor = Colors.grey[200]!,
        shadowColor = const Color(0x1F000000),
        tabBarColor = Colors.white;

  AppColors._internalDark()
      : textColor = Colors.white,
        textGreyColor = Colors.grey,
        backgroundColor = Colors.grey.shade900,
        contentBoxColor = Colors.black,
        contentBoxGreyColor = Colors.grey.shade700,
        iconColor = Colors.white,
        primaryColor = _actionColor,
        accentColor = _actionColor,
        secondaryAccentColor = _secondaryActionColor,
        buttonColor = _actionColor,
        drawerColor = Colors.black,
        fillColor = Colors.transparent,
        hintColor = Colors.grey.shade400,
        labelColor = Colors.grey.shade200,
        focusedBorderColor = Colors.white, // same as text color
        enabledBorderColor = Colors.grey.shade400,
        borderColor = Colors.grey.shade400,
        dividerColor = Colors.black,
        popupBackgroundColor = Colors.grey[850]!,
        shadowColor = const Color.fromARGB(255, 18, 18, 18),
        tabBarColor = Colors.black;


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