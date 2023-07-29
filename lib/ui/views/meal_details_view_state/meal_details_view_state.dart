import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/data/models/api/category_model.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/meal_details_view_state/meal_details_controller.dart';

class MealDetailsView extends StatefulWidget {
  final MealModel model;
  MealDetailsView({Key? key, required this.model}) : super(key: key);

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  late MealDetailsController controller;

  @override
  void initState() {
    controller = Get.put(MealDetailsController(widget.model));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Price: ${widget.model.price ?? '1000'}',
              style: TextStyle(fontSize: screenWidth(10)),
            ),
            Obx(() {
              return Row(
                children: [
                  CustomButton(
                    text: '-',
                    backgroundColor: controller.count == 1
                        ? AppColors.textColormain
                        : AppColors.mainOrangeColor,
                    onPressed: () {
                      controller.changeCount(false);
                    },
                  ),
                  CustomButton(text: controller.count.value.toString()),
                  CustomButton(
                    text: '+',
                    onPressed: () {
                      controller.changeCount(true);
                    },
                  ),
                ],
              );
            }),
            Obx(() {
              return Text(
                '${controller.calcTotal()}',
                style: TextStyle(fontSize: screenWidth(10)),
              );
            }),
            CustomButton(
              text: 'add',
              onPressed: () {
                controller.addToCart();
              },
            )
          ],
        ),
      ),
    );
  }
}