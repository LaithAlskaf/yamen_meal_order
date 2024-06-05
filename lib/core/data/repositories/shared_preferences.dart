import 'dart:convert';
import 'package:get/get.dart';
import 'package:mealorder/app/app_config.dart';
import 'package:mealorder/core/data/models/api/token_info.dart';
import 'package:mealorder/core/data/models/card_model.dart';
import 'package:mealorder/core/enums/data_type.dart';
import 'package:mealorder/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferance {
  SharedPreferences globalSharedPrefs = Get.find();
   String PREF_FIRST_LANUCH = 'first_lunch';
   String PREE_FIRSTLOGIN = 'first_login';
   String PREF_TOKEN = 'first_login';
   String PREF_APP_LANG = 'app_languages';
   String PREF_LOGGED_IN = 'logged_in';
   String PREF_CART_LIST = 'cart_list';

  void setFirstLunch(bool value) {
    setPerference(
      dataType: DataType.BOOL,
      key: PREF_FIRST_LANUCH,
      value: value,
    );
  }


  bool getFirstLunch() {
    if (globalSharedPrefs.containsKey(PREF_FIRST_LANUCH)) {
      return getPrefernce(key: PREF_FIRST_LANUCH);
    } else {
      return true;
    }
  }
  void setCartList(List<CartModel> list) {
    setPerference(
      dataType: DataType.STRING,
      key: PREF_CART_LIST,
      value: CartModel.encode(list),
    );
  }

  List<CartModel> getCartList() {
    if (globalSharedPrefs.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPrefernce(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }

   void setTokenIno(TokenInfo value) {
    setPerference(
      dataType: DataType.STRING,
      key: PREF_TOKEN,
      value: jsonEncode(value.toJson()),
    );
  }

   void setAppLanguage(String value) {
    setPerference(dataType: DataType.STRING, key: PREF_APP_LANG, value: value);
  }

   String getAppLanguage() {
    if (globalSharedPrefs.containsKey(PREF_APP_LANG)) {
      return getPrefernce(key:PREF_APP_LANG);
    } else {
      return AppConfig.defaultLanguage;
    }
  }

  setLoggedIN(bool value) {
    setPerference(
      dataType: DataType.BOOL,
      key: PREF_LOGGED_IN,
      value: value,
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedPrefs.containsKey(PREF_TOKEN)) {
      return TokenInfo.fromJson(
        jsonDecode(getPrefernce(key: PREF_TOKEN)),
      );
    } else {
      return null;
    }
  }

   dynamic getPrefernce({required String key}) {
    return globalSharedPrefs.get(key);
  }

   setPerference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPrefs.setInt(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPrefs.setDouble(key, value);
        break;
      case DataType.STRING:
        await globalSharedPrefs.setString(key, value);
        break;
      case DataType.STRINGLIST:
        await globalSharedPrefs.setStringList(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPrefs.setBool(key, value);
        break;
    }
  }
  bool get isLoggedIn=>getTokenInfo()!=null? true:false;
}
