import 'package:mealorder/core/data/network/network_config.dart';
class CategoryEndPoints {
  static String getallCategory=NetworkConfig.getFullApiRout('Category/getAll');
  static String getallMeal=NetworkConfig.getFullApiRout('Meal/getAll');
}