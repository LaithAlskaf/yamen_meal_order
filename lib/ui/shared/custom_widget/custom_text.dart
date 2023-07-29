import 'package:flutter/material.dart';
import 'package:mealorder/ui/shared/colors.dart';

import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSizeText;
  final FontWeight? fontWeightText;
  final TextAlign? textAlign;
  const CustomText(
      {Key? key,
      required this.text,
      this.textColor,
      this.fontSizeText,
      this.fontWeightText = FontWeight.normal, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,textAlign: textAlign,
      style: TextStyle(
          color: textColor ?? AppColors.textColormain,
          fontSize: fontSizeText ?? 14.sp,
          fontWeight: fontWeightText,
          fontFamily: "Metropolis"),
    );
  }
}
