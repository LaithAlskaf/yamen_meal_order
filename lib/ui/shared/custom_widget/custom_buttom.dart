import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    this.backgroundColor = const Color.fromRGBO(252, 96, 17, 1),
    required this.text,
    this.textColor = const Color.fromRGBO(252, 252, 252, 1),
    this.borderColor,
    this.paddingElevatedVertical,
    this.paddingElevatedHorizontal,
     this.imageName, this.sizeElevatedHieght, this.sizeElevatedWidth, this.sizeOfText,
  }) : super(key: key);

  final Function? onPressed;
  final Color? backgroundColor;
  final String text;
  final Color? textColor;
  final double? sizeOfText;
  final Color? borderColor;
  final String? imageName;

  // final bool? sizeElevatedBolean;
  final double? sizeElevatedHieght;
  final double? sizeElevatedWidth;
  final double? paddingElevatedVertical;
  final double? paddingElevatedHorizontal;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingElevatedHorizontal ?? 5.w,
          vertical: paddingElevatedVertical ?? 4.h),
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(sizeElevatedWidth??screenWidth(1.4).w,sizeElevatedHieght?? screenHeight(7.5)),
          shape: const StadiumBorder(),
          elevation: 0,
          backgroundColor: backgroundColor,
          side: borderColor != null
              ? BorderSide(
                  width: 1.0,
                  color: borderColor!,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageName != null) ...[SvgPicture.asset('assest/images/$imageName.svg'),
            SizedBox(width:screenWidth(20),),],
            Text(
              text,
              style: TextStyle(color: textColor,fontFamily: "Metropolis",fontSize: sizeOfText??18),
            ),
          ],
        ),
      ),
    );
  }
}
// background ?? Colors.red  اذا كانت null عطيا هي القيمة
