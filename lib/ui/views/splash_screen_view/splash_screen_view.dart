import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/splash_screen_view/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenController? controller;
  @override
  void initState() {
    controller=Get.put(SplashScreenController());
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assest/images/bg_background.jpg',
          width: width,
          height: height,
        ),
        Center(
          child: SvgPicture.asset(
            'assest/images/Logo.svg',
            width: screenWidth(2),
            height: screenHeight(2),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: screenHeight(1.1)),
            // width: size.width*0.09,
            // height: 1.h,
            child: SpinKitThreeBounce(
              color: AppColors.mainOrangeColor,
            ))
      ],
    )));
  }
}
