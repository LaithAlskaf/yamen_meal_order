import 'package:get/get.dart';
import 'package:mealorder/core/data/models/api/category_model.dart';
import 'package:mealorder/core/data/models/card_model.dart';
import 'package:mealorder/ui/shared/utils.dart';

class CartServices {
  RxList<CartModel> cartList = storage.getCartList().obs;

  RxInt cartCount = 0.obs;

  RxDouble subTotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble deliverFees = 0.0.obs;
  RxDouble total = 0.0.obs;

  CartService() {
    getCartCount();
    calcCartTotal();
  }

  void addToCart({
    required MealModel model,
    required int count,
    Function? afterAdd,
  }) {
    double mealTotal = calcMealTotal(count: count, model: model);
    if (getCartModel(model) != null) {
      int index = getIndex(getCartModel(model)!);
      cartList[index].count = cartList[index].count! + count;
      cartList[index].total = cartList[index].total! + mealTotal;
    } else {
      cartList.add(CartModel(
        count: count,
        total: mealTotal,
        meal: model,
      ));
    }
    storage.setCartList(cartList);
    cartCount.value += count;
    if (afterAdd != null) afterAdd();

    calcCartTotal();
  }

  void removeFromCartList(CartModel model) {
    cartList.remove(model);
    cartCount.value -= model.count!;

    storage.setCartList(cartList);

    calcCartTotal();
  }

  void changeCount(
      {required bool incress,
        required CartModel model,
        Function? afterChange}) {
    CartModel? result = getCartModel(model.meal!);

    int index = getIndex(result!);

    if (incress) {
      result.count = result.count! + 1;
      result.total = result.total! + model.meal!.price!.toDouble();
      cartCount.value += 1;
      calcCartTotal();
    } else {
      if (result.count! > 1) {
        result.count = result.count! - 1;
        result.total = result.total! - model.meal!.price!.toDouble();
        cartCount.value -= 1;
        calcCartTotal();
      }
    }

    cartList.remove(result);
    cartList.insert(index, result);

    storage.setCartList(cartList);
    if (afterChange != null) afterChange();
  }

  void clearCart() {
    cartList.clear();
    cartCount.value = getCartCount();
    calcCartTotal();

    storage.setCartList(cartList);
  }

  double calcMealTotal({required MealModel model, required int count}) {
    return (model.price! * count).toDouble();
  }

  CartModel? getCartModel(MealModel model) {
    try {
      return cartList.firstWhere(
            (element) => element.meal!.mealId == model.mealId,
      );
    } catch (e) {
      return null;
    }
  }

  int getCartCount() {
    cartCount.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.count!);

    return cartCount.value;
  }

  int getIndex(CartModel model) => cartList.indexOf(model);

  void calcCartTotal() {
    subTotal.value = 0.0;
    tax.value = 0.0;
    deliverFees.value = 0.0;
    total.value = 0.0;

    subTotal.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.total!);
    tax.value += subTotal.value * taxAmount;
    deliverFees.value += (subTotal.value + tax.value) * deliverAmount;
    total.value = subTotal.value + deliverFees.value + tax.value;
  }
}


































                               // Code From Abd_ALRAHMAN //
//________________________________________________________________________________________
//_________________________________________________________________________________________
// import 'package:get/get.dart';
// import 'package:mealorder/core/data/models/api/category_model.dart';
//
// import 'package:mealorder/core/data/models/card_model.dart';
// import 'package:mealorder/ui/shared/utils.dart';
//
// class CartService {
//   RxList<CartModel> cartList = storage.getCartList().obs;
//  RxInt count = 0.obs;
//   CartService (){
//     getCartCount();
//   }
//   CartModel? getCartModel(MealModel mealModel) {
//     try {
//       return cartList.firstWhere(
//         (element) => element.meal!.mealId == mealModel.mealId,
//       );
//     } catch (e) {
//       return null;
//     }
//   }
//
//   int getIndex(CartModel cartModel) => cartList.indexOf(cartModel);
//
//   int getCartCount() {
//     return cartList.fold(
//       0,
//       (previousValue, element) => previousValue + element.count!,
//     );
//   }
//
//   double calcMealTotal({
//     required MealModel mealModel,
//     required int count,
//   }) {
//     return (mealModel.price! * count).toDouble();
//   }
//
//   double calcCartSubTotal() {
//     // double subTotal = 0.0;
//     // cartList.forEach((element) {
//     //   subTotal += element.total ?? 0.0;
//     // });
//     return cartList.fold(
//       0,
//       (previousValue, element) => previousValue + element.total!,
//     );
//   }
//
//   double calcCartTax() {
//     return calcCartSubTotal() * taxAmount;
//   }
//
//   // double calcCartDeliveryFees() {
//   //   return (calcCartSubTotal() + calcCartTax()) * deliveryFeesAmount;
//   // }
//
//   double calcCartTotal() {
//     return calcCartSubTotal() + calcCartTax() + calcCartDeliveryFees();
//   }
//
// // //!---- Check if Meal Exist in Cart List ----
// //   bool isMealExist({
// //     required MealModel mealModel,
// //   }) {
// //     CartModel? result = cartList.firstWhere(
// //       (element) {
// //         return element.mealModel!.id == mealModel.id;
// //       },
// //       orElse: () {
// //         return CartModel();
// //       },
// //     );
// //     return result.count != null;
// //   }
//
// // //!---- Get Cart Item Index ----
// //   int getIndex({
// //     required CartModel cartModel,
// //   }) {
// //     if (isMealExist(
// //       mealModel: cartModel.mealModel!,
// //     )) {
// //       int index = cartList.indexOf(cartModel);
// //       return index;
// //     } else
// //       return -1;
// //   }
//
// //!---- Add Item to Cart ----
//   void addToCartList({
//     required MealModel mealModel,
//     required int count,
//     Function? afterAdd,
//   }) {
//     double mealTotal = calcMealTotal(count: count, mealModel: mealModel);
//     if (getCartModel(mealModel) != null) {
//       int index = getIndex(getCartModel(mealModel)!);
//       cartList[index].count = cartList[index].count! + count;
//       cartList[index].total = cartList[index].total! + mealTotal;
//     } else {
//       cartList.add(
//         CartModel(
//           count: count,
//           total: mealTotal,
//           meal: mealModel,
//         ),
//       );
//     }
//     storage.setCartList(cartList);
//     if (afterAdd != null) afterAdd();
//   }
//
//   void removeFromCartList({
//     required CartModel cartModel,
//     Function? afterRemove,
//   }) {
//     cartList.remove(cartModel);
//     storage.setCartList(cartList);
//     if (afterRemove != null) afterRemove();
//   }
//
//   void changeMealCount({
//     required bool increase,
//     required CartModel cartModel,
//     Function? afterChange,
//   }) {
//     CartModel result = getCartModel(cartModel.meal!)!;
//     int index = cartList.indexOf(result);
//     double mealTotal =
//         calcMealTotal(mealModel: result.meal!, count: result.count!);
//
//     if (increase) {
//       result.count = result.count! + 1;
//       result.total = result.total! + mealTotal;
//       count++;
//     } else {
//       if (result.count! > 1) {
//         result.count = result.count! - 1;
//         result.total = result.total! - mealTotal;
//       }
//     }
//     cartList.remove(result);
//     cartList.insert(index, result);
//     storage.setCartList(cartList);
//     if (afterChange != null) afterChange();
//     calcCartTotal();
//   }
//
// }
