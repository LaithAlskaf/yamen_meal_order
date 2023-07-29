import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/data/repositories/shared_preferences.dart';
import 'package:mealorder/core/enums/botton_navigation.dart';
import 'package:mealorder/ui/views/main_view/home_view/home_view.dart';
import 'package:mealorder/ui/views/main_view/menu_view/menu_view.dart';
import 'package:mealorder/ui/views/main_view/more_view/more_view.dart';
import 'package:mealorder/ui/views/main_view/offers_view/offers_view.dart';
import 'package:mealorder/ui/views/main_view/profile_view/profile_view.dart';
import 'package:mealorder/ui/views/main_view/shared_buttom_widget_view/bottom_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../landing_view/landing_view.dart';

class ShoppingPageView extends StatefulWidget {
  const ShoppingPageView({Key? key}) : super(key: key);

  @override
  State<ShoppingPageView> createState() => _ShoppingPageViewState();
}

class _ShoppingPageViewState extends State<ShoppingPageView> {
  BottonNavigationEnum selected = BottonNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 2);
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      key: scafoldKey,
      drawer: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('option1'),
          const SizedBox(
            height: 5,
          ),
          const Text('option2'),
          const SizedBox(
            height: 5,
          ),
          const Text('option3'),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            child: Container(
              color: Colors.tealAccent,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              child: const Text(
                'log out',
                style: TextStyle(fontSize: 25),
              ),
            ),
            onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                if (SharedPreferance().getTokenInfo() == null) {
                  Get.off(const LandingView());
                }
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        bottomNavigationEnum: selected,
        onTap: (selectedEnum, pageNumber) {
          setState(() {
            selected = selectedEnum;
          });

          controller.animateToPage(pageNumber,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeInCirc);
        },
      ),
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (pageNumber) {},
        children: [
          MenuView(onMenuTap: () {
            scafoldKey.currentState!.openDrawer();
          }),
          const OffersView(),
          const HomeView(),
          const ProfileView(),
          const MoreView()
        ],
      ),
    ));
  }
}
