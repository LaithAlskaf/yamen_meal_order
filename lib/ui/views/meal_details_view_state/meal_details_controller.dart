import 'package:get/get.dart';
import 'package:mealorder/core/data/models/api/category_model.dart';
import 'package:mealorder/core/data/models/card_model.dart';
import 'package:mealorder/core/services/base_controller.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/card_view/card_view.dart';

class MealDetailsController extends BaseController {
  MealModel model = MealModel();

  MealDetailsController(MealModel mealModel) {
    model = mealModel;
  }

  RxInt count = 1.obs;

  void changeCount(bool incress) {
    if (incress) {
      count++;
    } else {
      if (count > 1) {
        count--;
      }
    }
  }

  double calcTotal() {
    return (count.value * model.price!).toDouble();
  }

  void addToCart() {
    List<CartModel> list = storage.getCartList();

    CartModel? result = list.firstWhere(
        (element) => element.meal!.mealId == model.mealId, orElse: () {
      return CartModel();
    });

    if (result.count != null) {
      int index = list.indexOf(result);
      list[index].count = list[index].count! + count.value;
      list[index].total = list[index].total! + calcTotal();
    } else {
      list.add(CartModel(
        count: count.value,
        total: calcTotal(),
        meal: model,
      ));
    }

    storage.setCartList(list);
    Get.to(CartView());
  }
}
