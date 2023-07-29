import 'package:get/get.dart';
import 'package:mealorder/core/data/models/api/category_model.dart';
import 'package:mealorder/core/data/repositories/category_repositiory.dart';
import 'package:mealorder/core/data/repositories/meal_repositiory.dart';
import 'package:mealorder/core/enums/message_type.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';

class HomeViewcontroller extends GetxController {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<MealModel> mealList = <MealModel>[].obs;


  @override
  onInit() {
    getAllCategory();
    getALlMeal();
    super.onInit();
  }

  void getAllCategory() {
    CategoryRepository().getAll().then((value) => value.fold(
            (l) => CustomToast.showMessage(
            message: l, messageType: MessageType.REJECTED),
            (r) => categoryList.addAll(r)));
  }

  void getALlMeal() {
    MealRepositiory().getAll().then((value) => value.fold(
            (l) => CustomToast.showMessage(
            message: l, messageType: MessageType.REJECTED),
            (r) => mealList.addAll(r)));
  }

}