
import 'package:flutter/material.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/utils.dart';

class MenuView extends StatelessWidget {
  final Function onMenuTap;
  const MenuView({Key? key, required this.onMenuTap, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: (){onMenuTap;},
        child: Container(color: Colors.blue,
          width: screenWidth(1.4),
          height: screenWidth(5),
          child: Text(
            'Menu page',
            style: TextStyle(fontSize: 50, color: AppColors.mainOrangeColor,),textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
