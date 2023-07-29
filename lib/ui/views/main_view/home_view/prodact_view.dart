import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/translation/app_translation.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/main_view/home_view/prodact_controller.dart';

class ProdactView extends StatelessWidget {
  ProdactView({Key? key}) : super(key: key);
  ProdactViewcontroller controller = Get.put(ProdactViewcontroller());

  @override
  Widget build(BuildContext context) {
    final int priceOfProdact = 750;
    int numberOfProdact = 0;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
            SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: width,
                height: 240,
                imageUrl:
                'https://cdn.esawebb.org/archives/images/screen/potm2208a.jpg',
                placeholder: (context, url) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 290,top: 170),
              //   child: Text('$priceOfProdact',style: TextStyle(fontSize: 50,color: AppColors.mainOrangeColor),),
              // ),
              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                    children: [
                    CustomText(text: 'Tandoori Chicken Pizza'),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) =>
                            Icon(
                              Icons.star,
                              color: AppColors.mainOrangeColor,
                            ),
                        unratedColor: Colors.white,
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                Row(children: [
                  Text('4 star Ratings'),
                  SizedBox(width: screenWidth(3),),
                  Text('Rs.$priceOfProdact',style: TextStyle(fontSize: 50,color: AppColors.mainOrangeColor),),
                ],)
            ],
          ),
        )
        ],
      ),

      Row(
        children: [
          Text(
            'number of Prodact',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 2,
          ),
          CustomButton(
              text: "-",
              onPressed: () {
                controller.deincrement();
              },
              sizeElevatedWidth: screenWidth(10),
              sizeOfText: 50),
          SizedBox(
            width: 2,
          ),
          Obx(
                () =>
                Text(
                  '${controller.numberOfProdact}',
                  style: TextStyle(fontSize: 25),
                ),
          ),
          CustomButton(
            text: "+",
            onPressed: () {
              controller.increment();
            },
            sizeElevatedWidth: screenWidth(10),
            sizeOfText: 50,
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Obx(
            () =>
            Text(
              'Total is : ${controller.PriceOfProdact()}',
              style: TextStyle(fontSize: 50),
            ),
      )
      ],
    ),)
    ,
    )
    );
  }
}
