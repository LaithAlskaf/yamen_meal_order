import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/enums/url_launcher_type.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:mealorder/ui/shared/extension_sizebox.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/main_view/home_view/home_controller.dart';
import 'package:mealorder/ui/views/main_view/home_view/prodact_view.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/custom_widget/custom_text.dart';
import '../../card_view/card_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> options = ['Current Location', 'Option 2', 'Option 3'];
  String selectedOption = 'Current Location';
  @override
  HomeViewcontroller? controller;
  void initState() {
    // TODO: implement initState
     controller = Get.put(HomeViewcontroller());
    super.initState();
  }
  String bb = "https://cdn.esawebb.org/archives/images/screen/potm2208a.jpg";
  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: screenWidth(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: "Good morning Akila!",
                      fontSizeText: 20.sp,
                      textColor: AppColors.textColorLoginSign,
                    ),
                    SizedBox(
                      width: screenWidth(5),
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(CartView());
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: AppColors.mainOrangeColor,
                      ),
                    )
                  ],
                ),
                28.ph,
                Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: 'Delivering to',
                      fontSizeText: 10.sp,
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textColormain,
                          fontWeight: FontWeight.bold),
                      value: selectedOption,
                      items: options.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Padding(
                            padding: EdgeInsets.only(right: screenWidth(10)),
                            child: Text(option),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                TextFormFieldSIgnUP(
                    hintText: "Search food",
                    paddingHorizontal: 0,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textColormain,
                      size: 24.sp,
                    )),
                Obx(() => controller!.mealList.isEmpty
                    ? SpinKitCircle(
                        color: AppColors.mainOrangeColor,
                      )
                    : SizedBox(
                        height: screenHeight(3.6),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller!.mealList.length,
                          addAutomaticKeepAlives: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Column(children: [
                                CachedNetworkImage(
                                  width: 90,
                                  imageUrl: bb,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Text(
                                  controller!.mealList[index].name ?? '',
                                  style: const TextStyle(fontSize: 20),
                                )
                              ]),
                            );
                          },
                        ),
                      )),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 25),
                  child: Row(
                    mainAxisAlignment:   MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Popular Restaurents',
                          style: TextStyle(color: Colors.black, fontSize: 26)),
                      Text(
                        'View all',
                        style: TextStyle(color: AppColors.mainOrangeColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() => controller!.categoryList.isEmpty
              ? SpinKitCircle(
                  color: AppColors.mainOrangeColor,
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller!.categoryList.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){Get.to(ProdactView());},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.ph,
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: width,
                            height: 300,
                            imageUrl: bb,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          10.ph,
                          Padding(
                            padding: const EdgeInsets.only(left: 26),
                            child: Text(
                              'Bakes by Tella',
                              style: TextStyle(
                                  color: AppColors.textColorLoginSign,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 26, top: 5, bottom: 18),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.mainOrangeColor,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    '4.9',
                                    style: TextStyle(
                                        color: AppColors.mainOrangeColor,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Text(
                                    ' (124 ratings) Café',
                                    style: TextStyle(
                                        color: Color.fromRGBO(182, 183, 183, 1),
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    ' . ',
                                    style: TextStyle(
                                        color: AppColors.mainOrangeColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Text('Western Food',
                                      style: TextStyle(
                                          color: Color.fromRGBO(182, 183, 183, 1),
                                          fontSize: 15))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 25, left: 26, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Most Popular',
                    style: TextStyle(color: Colors.black, fontSize: 26)),
                Text(
                  'View all',
                  style: TextStyle(color: AppColors.mainOrangeColor),
                )
              ],
            ),
          ),
          Obx(() => controller!.categoryList.isEmpty
              ? SpinKitCircle(
                  color: AppColors.mainOrangeColor,
                )
              : SizedBox(
                  height: screenHeight(1.5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller!.categoryList.length,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 21),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              // width: 120,
                              height: 200,
                              imageUrl: bb,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            5.ph,
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: Text(
                                'Bakes by Tella',
                                style: TextStyle(
                                    color: AppColors.textColorLoginSign,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Café',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 183, 183, 1),
                                      fontSize: 15),
                                ),
                                Text(
                                  ' . ',
                                  style: TextStyle(
                                      color: AppColors.mainOrangeColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                2.pw,
                                const Text('Western Food',
                                    style: TextStyle(
                                        color: Color.fromRGBO(182, 183, 183, 1),
                                        fontSize: 15)),
                                14.pw,
                                Icon(
                                  Icons.star,
                                  color: AppColors.mainOrangeColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '4.9',
                                  style: TextStyle(
                                      color: AppColors.mainOrangeColor,
                                      fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Items',
                    style: TextStyle(color: Colors.black, fontSize: 26)),
                Text(
                  'View all',
                  style: TextStyle(color: AppColors.mainOrangeColor),
                )
              ],
            ),
          ),
          Obx(() => controller!.categoryList.isEmpty
              ? SpinKitCircle(
                  color: AppColors.mainOrangeColor,
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller!.categoryList.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 23, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                                imageUrl: bb,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              20.pw,
                              Column(
                                children: [
                                  Text(
                                    'Mulberry Pizza',
                                    style: TextStyle(
                                        color: AppColors.textColorLoginSign,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  5.ph,
                                  Row(
                                    children: [
                                      const Text('Café',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  182, 183, 183, 1),
                                              fontSize: 15)),
                                      Text(
                                        ' . ',
                                        style: TextStyle(
                                            color: AppColors.mainOrangeColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Text('Western Food',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  182, 183, 183, 1),
                                              fontSize: 15))
                                    ],
                                  ),
                                  5.ph,
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.mainOrangeColor,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                            color: AppColors.mainOrangeColor,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Text(
                                        ' (124 ratings)',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                182, 183, 183, 1),
                                            fontSize: 15),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         urlLauncher(
          //             launcher: UrlLauncherType.FAEBOOK, face: 'rtrts2');
          //       },
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         padding: EdgeInsets.all(9.0),
          //         margin: EdgeInsets.all(8.0),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.transparent,
          //         ),
          //         child: Center(
          //             child: Icon(
          //           FontAwesomeIcons.facebook,
          //           color: Colors.blue,
          //           size: 40,
          //         )),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         urlLauncher(
          //             launcher: UrlLauncherType.INSTAGRAM,
          //             instagram: 'laith_alskaf');
          //       },
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         padding: EdgeInsets.all(9.0),
          //         margin: EdgeInsets.all(8.0),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.transparent,
          //         ),
          //         child: Center(
          //             child: Icon(FontAwesomeIcons.instagram,
          //                 color: Colors.red, size: 40)),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         urlLauncher(
          //             launcher: UrlLauncherType.WHATSAPP,
          //             whatsapp: 963935754432);
          //       },
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         padding: EdgeInsets.all(9.0),
          //         margin: EdgeInsets.all(8.0),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.transparent,
          //         ),
          //         child: Center(
          //             child: Icon(
          //           FontAwesomeIcons.whatsapp,
          //           color: Colors.green,
          //           size: 40,
          //         )),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Future<void> urlLauncher(
      {required UrlLauncherType launcher,
      String? face,
      int? whatsapp,
      String? instagram}) async {
    try {
      switch (launcher) {
        case UrlLauncherType.FAEBOOK:
          if (await canLaunch('https://www.facebook.com/$face')) {
            await launch('https://www.facebook.com/$face');
          }
          break;
        case UrlLauncherType.WHATSAPP:
          if (await canLaunch('https://wa.me/$whatsapp')) {
            await launch('https://wa.me/$whatsapp');
          }

          break;
        case UrlLauncherType.YOUTUBE:
          if (await canLaunch('https://www.facebook.com/')) {
            await launch('https://www.facebook.com/');
          }
          break;
        case UrlLauncherType.INSTAGRAM:
          if (await canLaunch('https://www.instagram.com/$instagram')) {
            await launch('https://www.instogram.com/$instagram');
          }
          break;
      }
    } catch (e) {
      e;
    }
  }
}
