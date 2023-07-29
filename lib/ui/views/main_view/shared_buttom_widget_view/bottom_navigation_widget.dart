import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mealorder/core/enums/botton_navigation.dart';
import 'package:mealorder/ui/views/main_view/shared_buttom_widget_view/bottom_navigation_clipper.dart';

import '../../../shared/colors.dart';

class BottomNavigationWidget extends StatefulWidget {
  final BottonNavigationEnum bottomNavigationEnum;
 final Function (BottonNavigationEnum,int) onTap;
  const BottomNavigationWidget({Key? key, required this.bottomNavigationEnum, required this.onTap})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}
class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.bottomCenter,
       fit: StackFit.loose,
      children: [
        CustomPaint(
          painter: _ClipShadowShadowPainter(
            clipper: BottomNavigationClipper(),
            shadow: Shadow(
              blurRadius: 15,
              color: AppColors.textColormain,
            ),
          ),
          child: ClipPath(
            clipper: BottomNavigationClipper(),
            child: Container(
              width: size.width,
              height: size.height * 0.105,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: AppColors.textColor,
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              navItem(
                  imageName: 'ic_menu',
                  text: 'Menu',
                  isSelected: widget.bottomNavigationEnum ==
                      BottonNavigationEnum.MENU,
                  onTap: () {widget.onTap(BottonNavigationEnum.MENU, 0);},
                  size: size),
              navItem(
                  imageName: 'ic_shopping',
                  text: 'Offers',
                  isSelected: widget.bottomNavigationEnum ==
                      BottonNavigationEnum.OFFERS,
                  onTap: () {widget.onTap(BottonNavigationEnum.OFFERS, 1);},
                  size: size),
              SizedBox(
                width: size.width * 0.25,
              ),
              navItem(
                  imageName: 'ic_user',
                  text: 'Profile',
                  isSelected: widget.bottomNavigationEnum ==
                       BottonNavigationEnum.PROFILE,
                  onTap: () {widget.onTap(BottonNavigationEnum.PROFILE, 3);},
                  size: size),
              navItem(
                  imageName: 'ic_more',
                  text: 'More',
                  isSelected: widget.bottomNavigationEnum ==
                  BottonNavigationEnum.MORE,
                  onTap: () {widget.onTap(BottonNavigationEnum.MORE, 4);},
                  size: size),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.13),
          child: InkWell(
            onTap: (){widget.onTap(BottonNavigationEnum.HOME, 2);},
            child: CircleAvatar(
              backgroundColor: widget.bottomNavigationEnum==BottonNavigationEnum.HOME?AppColors.mainOrangeColor:AppColors.textColormain,
              radius: size.width * 0.1,
              child: SvgPicture.asset('assest/images/ic_home.svg',color: Colors.white,),
            ),
          ),
        ),
      ],
    );
  }
  Widget navItem({
    required String imageName,
    required String text,
    required bool isSelected,
    required Function onTap,
    required Size size,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assest/images/$imageName.svg',
            color: isSelected
                ? AppColors.mainOrangeColor
                : AppColors.textColormain,
            width: size.width*0.05,
          ),
          SizedBox(
            height: size.width * 0.02,
          ),
          Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? AppColors.mainOrangeColor
                  : AppColors.textColormain,
            ),
          )
        ],
      ),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

