import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/card_view/card_view_controller.dart';

class CartView extends StatefulWidget {
  CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

  class _CartViewState extends State<CartView> {
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.cartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.cartList[index].meal!.name ?? '',
                              style: TextStyle(fontSize: screenWidth(10)),
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.removeFromCartList(
                                      controller.cartList[index]);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                        Row(
                          children: [
                            CustomButton(
                              text: '+',
                              onPressed: () {
                                controller.changeCount(
                                    true, controller.cartList[index]);
                              },
                            ),
                            Text(controller.cartList[index].count.toString(),
                                style: TextStyle(fontSize: screenWidth(10))),
                            CustomButton(
                              text: '-',
                              onPressed: () {
                                controller.changeCount(
                                    false, controller.cartList[index]);
                              },
                            ),
                          ],
                        ),
                        Text(controller.cartList[index].total.toString(),
                            style: TextStyle(fontSize: screenWidth(10))),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      color: AppColors.mainOrangeColor,
                      width: screenWidth(1),
                      height: 2,
                    );
                  },
                );
              })
            ],
          )),
    );
  }
}