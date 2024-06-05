import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mealorder/core/translation/app_translation.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/splash_screen_view/splash_screen_view.dart';

import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // String deviceLanguage = window.locale.languageCode;
    // Get.put(MyAPPController());
    // Get.find<MyAPPController>().updateDeviceLanguage(deviceLanguage);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: GetPlatform.isAndroid
            ? Transition.fadeIn
            : Transition.cupertino,
        transitionDuration: const Duration(microseconds: 300),
        translations: AppTranslation(),
        locale: getLocal(),
        fallbackLocale: getLocal(),
        builder: BotToastInit(),
        //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
        //2. registered route observer
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreenView(),
      );
    });
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar') {
    return const Locale('ar', 'SA');
  } else if (storage.getAppLanguage() == 'tr') {
    return const Locale('tr', 'TR');
  } else {
    return const Locale('en', 'US');
  }
}
