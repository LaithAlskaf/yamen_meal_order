
import 'package:flutter/material.dart';
import 'package:mealorder/ui/shared/colors.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Menu page',
        style: TextStyle(fontSize: 25, color: AppColors.textColormain),
      ),
    );
  }
}
