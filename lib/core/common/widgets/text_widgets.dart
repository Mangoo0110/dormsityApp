
import 'package:flutter/material.dart';

import '../../utils/constants/app_sizes.dart';

class TextWidgets {

  final double _small = AppSizes.smallTextSize;

  final double _medium = AppSizes.mediumTextSize;

  final double _large = AppSizes.largeTextSize;

  final double _xtralarge = AppSizes.extraLargeTextSize;

  final double _headerSize = AppSizes.extraLargeTextSize + 1;

  BuildContext context;

  TextWidgets(this.context);

  Widget headerMedium({required String headerText}) {
    return Text(headerText,  style: Theme.of(context).textTheme.headlineMedium,  maxLines: 1);
  }

  Widget buttonText({required String buttonText}) {
    return Text(buttonText,  style: Theme.of(context).textTheme.titleSmall, maxLines: 1,);
  }

  Widget normalText({required String text}) {
    return Text(text,  style: Theme.of(context).textTheme.bodyMedium, maxLines: 1,);
  }

  Widget buttonTextHigh({required String buttonText, required Color textColor}) {
    return Text(buttonText,  style: Theme.of(context).textTheme.titleLarge, maxLines: 1,);
  }

  Widget buttonMedium({required String buttonText, required Color textColor}) {
    return Text(buttonText,  style: Theme.of(context).textTheme.titleMedium, maxLines: 1,);
  }

  Widget titleLarge({required String titleText, required Color textColor}) {
    return Text(titleText,  style: Theme.of(context).textTheme.titleLarge, maxLines: 2,);
  }

  Widget subtitleSmall({required String titleText, required Color textColor}) {
    return Text(titleText,  style: Theme.of(context).textTheme.titleSmall, maxLines: 1,);
  }

  Widget subtitleTextSize({required String titleText, required Color textColor, required double fontSize}) {
    return Text(titleText,  style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis), maxLines: 1,);
  }

  Widget highLightText({required String text, required Color textColor}) {
    return Text(text, textAlign: TextAlign.center,  style: Theme.of(context).textTheme.titleMedium, maxLines: 2);
  }

  Widget highLightTextSize({required String text, required Color textColor, required double fontSize}) {
    return Text(text,  style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), maxLines: 2);
  }
}