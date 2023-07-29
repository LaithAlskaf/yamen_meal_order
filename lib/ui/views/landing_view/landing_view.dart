import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/extension_sizebox.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/login_view/login_view.dart';
import 'package:mealorder/ui/views/sign_up_view/sign_up_view.dart';
import 'package:sizer/sizer.dart';

import 'landing_clipper.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(shrinkWrap: true, children: [
          Stack(
            children: [
              CustomPaint(
                painter: _ClipShadowShadowPainter(
                  clipper: LandingClipper(),
                  shadow: const Shadow(blurRadius: 12),
                ),
                child: ClipPath(
                  clipper: LandingClipper(),
                  child: Container(
                    width: width,
                    height: screenHeight(1.1),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(252, 96, 17, 1)),
                    child: SvgPicture.asset(
                      'assest/images/Backgroundorang.svg',
                      fit: BoxFit.fitWidth,
                      width: width,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 33.h),
                  child: SvgPicture.asset(
                    'assest/images/Logo.svg',
                    width: screenWidth(2),
                    height: screenHeight(2),
                  ),
                ),
              ),
            ],
          ),
          37.ph,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Discover the best foods from over 1,000",
                fontSizeText: 12.sp,
              ),
              CustomText(
                text: "resturants and fast delivery to your doorstep",
                fontSizeText: 12.sp,
              ),
            ],
          ),
          CustomButton(
              onPressed: () {
                Get.off(const LogInView());
              },
              text: 'Login',
              textColor: AppColors.textColor,
              borderColor: AppColors.transletColor),
          CustomButton(
              paddingElevatedVertical: 0,
              onPressed: () {
                Get.off(const SignUpView());
              },
              text: 'Create an Account',
              textColor: AppColors.mainOrangeColor,
              borderColor: AppColors.mainOrangeColor,
              backgroundColor: Colors.white24),
        ]),
      ),
    );
  }
}
class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


