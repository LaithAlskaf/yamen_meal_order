import 'package:get/get.dart';
import 'package:mealorder/core/translation/app_translation.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/intro_view/intro_view.dart';
import 'package:mealorder/ui/views/landing_view/landing_view.dart';
import 'package:mealorder/ui/views/main_view/main_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (storage.getFirstLunch())
        {
           Get.off(const IntroView());

        }
      //to off back
      else{
        Get.off(storage.isLoggedIn? const ShoppingPageView() : const LandingView(),);
      }
      storage.setFirstLunch(false);
    });
    super.onInit();
  }
}
