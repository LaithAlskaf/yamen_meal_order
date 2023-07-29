import 'package:flutter/cupertino.dart';
import 'package:mealorder/ui/shared/colors.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile page',
        style: TextStyle(fontSize: 25, color: AppColors.textColormain),
      ),
    );
  }
}
