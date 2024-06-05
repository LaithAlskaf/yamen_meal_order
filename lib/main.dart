import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/app/my_app.dart';
import 'package:mealorder/app/my_app_controller.dart';
import 'package:mealorder/core/data/repositories/shared_preferences.dart';
import 'package:mealorder/core/services/connectivity_service.dart';
import 'package:mealorder/core/services/location_services/location_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/services/cart_services.dart';

SharedPreferences? globalSharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // globalSharedPreferences=await SharedPreferences.getInstance();

  await Get.putAsync<SharedPreferences>(
    () async {
      var sharedPref = await SharedPreferences.getInstance();
      return sharedPref;
    },
  );
  Get.put(SharedPreferance());
  Get.put(LocationService());
  Get.put(ConnectivityService());
  Get.put(MyAppController());
  Get.put(CartServices());
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    e;
  }

  runApp(const MyApp());
}
