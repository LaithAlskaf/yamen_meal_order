import 'package:flutter/material.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:mealorder/ui/shared/utils.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _firstNameFocusNewPassowrd= FocusNode();
  final _lastNameFocusConfirmPassword = FocusNode();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formState= GlobalKey<FormState>();

  send() {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      ('Its Ok');
    } else {
      ("NOt VALUE");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Form(key:formState,
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: CustomText(
                    text: 'New Password',
                    fontSizeText: 36,
                    fontWeightText: FontWeight.bold,
                    textColor: Colors.black87,
                  )),
              const CustomText(text: 'Please enter your email to receive a'),
              const CustomText(text: 'link to create a new password via email'),
              TextFormFieldSIgnUP(
                firstNameFocus: _firstNameFocusNewPassowrd,
                lastNameFocus: _lastNameFocusConfirmPassword,
                hintText: 'New Password',
                controller: newPasswordController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your Password';
                  } else if (!validatePassword(text)) {
                    return 'Password is not valid';
                  }
                  return null;
                },
              ),
              TextFormFieldSIgnUP(
                firstNameFocus: _lastNameFocusConfirmPassword,
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                validator: (text){
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your Confirm Password';
                  } else if (!isValidPassword(newPasswordController.text,confirmPasswordController.text)) {
                    return 'Confirm Password is not valid';
                  }
                  return null;
                },
              ),
              CustomButton(
                text: 'Next',
                onPressed: () {send();},
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
