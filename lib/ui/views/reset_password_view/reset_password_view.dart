import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/new_passowrd_view/verifiction_code_view.dart';
import 'package:sizer/sizer.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  send() {
    if (formState.currentState!.validate()) {
      Get.to(const SentCodeNewPasswordView());
    } else {
      ("NOT VALUE");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Align(
        child: Form(
          key: formState,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: screenWidth(9)),
                child: Text(
                  'Reset Paswword',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const CustomText(text: 'Please enter your email to recelve a'),
              const CustomText(
                  text: 'linke to create a new password via email'),
              TextFormFieldSIgnUP(
                hintText: 'Email',
                controller: emailController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                     return 'Please enter your email';
                  } else if (!isEmail(text)) {
                    return 'Email is not valid';
                  }
                  return null;
                },
              ),
               SizedBox(
                height: screenHeight(50),
              ),
              CustomButton(
                text: 'Send',
                onPressed: () {
                  send();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
