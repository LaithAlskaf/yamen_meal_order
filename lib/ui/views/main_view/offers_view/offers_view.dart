import 'package:flutter/cupertino.dart';
import 'package:mealorder/ui/shared/colors.dart';

class OffersView extends StatelessWidget {
  const OffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Offers page',
        style: TextStyle(fontSize: 25, color: AppColors.textColormain),
      ),
    );
  }
}
