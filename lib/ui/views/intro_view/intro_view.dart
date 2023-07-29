import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/extension_sizebox.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/landing_view/landing_view.dart';
import 'package:sizer/sizer.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() =>
      _IntroViewState();
}

class _IntroViewState
    extends State<IntroView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> textMain = [
      'Find Food You Love',
      'Fast Delivery',
      'Live Tracking',
    ];
    List<String> imageMain = [
      'Find_food_you_love_vector',
      'Live_tracking_vector',
      'Delivery_vector'
    ];
    List<String> textdecrpshn = [
      'Discover the best foods from over 1,000 \n restaurants and fast delivery to your doorstep',
      'Fast food delivery to your home, office \n wherever you are',
      'Real time tracking of your food on the app \n once you placed the order'
    ];

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(
              top: screenHeight(3),
              left: screenWidth(80),
              right: screenWidth(80),
            ),
            child: ListView(shrinkWrap: true,
              children: [
                Image.asset(
                  "assest/images/${imageMain[currentIndex]}.jpg",
                  width: screenWidth(1.1),
                  height: screenHeight(1.1),
                ),
                30.ph,
                DotsIndicator(
                  dotsCount: 3,
                  position: currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.textColormain, // Inactive color
                    activeColor: AppColors.mainOrangeColor,
                  ),
                ),
                28.ph,
                Center(
                    child: CustomText(
                      text: textMain[currentIndex],
                      fontSizeText: 23.sp,
                      textColor: AppColors.textColorLoginSign,
                    )),
                28.ph,
                Center(
                  child: CustomText(
                    text: textdecrpshn[currentIndex],
                    fontSizeText: 12.sp,
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomButton(
                    text: currentIndex == 2 ? 'Finish' : 'Next',
                    paddingElevatedVertical: screenHeight(10),
                    onPressed: () {
                      if (currentIndex != 2) {
                        setState(() {
                          currentIndex += 1;
                        });
                      } else {
                        Get.off(const LandingView());
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
