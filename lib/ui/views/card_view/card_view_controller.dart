import 'package:get/get.dart';
import 'package:mealorder/core/data/models/card_model.dart';
import 'package:mealorder/core/services/base_controller.dart';
import 'package:mealorder/ui/shared/utils.dart';

class CartController extends BaseController {
  RxList<CartModel> cartList = <CartModel>[].obs;
  @override
  void onInit() {
     cartList.value = storage.getCartList();
    super.onInit();
  }

  void removeFromCartList(CartModel model) {
    cartList.remove(model);
    storage.setCartList(cartList);
  }

  void changeCount(bool incress, CartModel model) {
    CartModel? result = cartList.firstWhere(
            (element) => element.meal!.mealId == model.meal!.mealId, orElse: () {
      return CartModel();
    });

    int index = cartList.indexOf(result);

    if (incress) {
      result.count = result.count! + 1;
      result.total = result.total! + model.meal!.price!.toDouble();
    } else {
      if (result.count! > 1) result.count = result.count! - 1;
      result.total = result.total! - model.meal!.price!.toDouble();
    }

    cartList.remove(result);
    cartList.insert(index, result);

    storage.setCartList(cartList);
  }
  double calcSubTotal() {
    double total = 0.0;
    cartList.forEach((element) {
      total += element.total ?? 0.0;
    });
    return total;
  }

  double calcTax() {
    return calcSubTotal() * taxAmount;
  }

  double calcDeliveryFees() {
    return (calcSubTotal() + calcTax()) * deliverAmount;
  }

  double calcTotal() {
    return calcSubTotal() + calcTax() + calcDeliveryFees();
  }
  //!--- Third ----
  // Map<String, double> calcTotals() {
  //   double subTotal = 0.0;
  //   double tax = 0.0;
  //   double deliverFees = 0.0;
  //   double total = 0.0;
  //
  //   cartList.forEach((element) {
  //     subTotal += element.total ?? 0.0;
  //   });
  //   tax += subTotal * taxAmount;
  //   deliverFees += (subTotal + tax) * deliverAmount;
  //   total = subTotal + deliverFees + tax;
  //
  //   return {
  //     "subTotal": subTotal,
  //     "tax": tax,
  //     "deliverFees": deliverFees,
  //     "total": total
  //   };
  // }
//_________________________________________________________________________
//!---- First -----

  // RxDouble subTotal = 0.0.obs;
  // RxDouble tax = 0.0.obs;
  // RxDouble deliverFees = 0.0.obs;
  // RxDouble total = 0.0.obs;
  //
  // void calcCartTotal() {
  //   subTotal.value = 0.0;
  //   cartList.forEach((element) {
  //     subTotal.value += element.total ?? 0.0;
  //   });
  //   tax.value += subTotal.value * taxAmount;
  //   deliverFees.value += (subTotal.value + tax.value) * deliverAmount;
  //   total.value = subTotal.value + deliverFees.value + tax.value;
  // }

}