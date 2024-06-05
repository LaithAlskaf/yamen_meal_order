import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/data/repositories/user_repositiory.dart';
import 'package:mealorder/core/enums/message_type.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';
import 'package:mealorder/ui/views/login_view/login_view.dart';

class SignUpController extends GetxController {
  RxBool islooding = false.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File? image;

  isloodingTrue() {
    islooding.value = true;
  }

  isloodingFalse() {
    islooding.value = false;
  }

  send({required GlobalKey<FormState> formState}) async {
    if (formState.currentState!.validate()) {
      ('Its Ok');
      isloodingTrue();

      await UserRepository()
          .register(
              email: emailController.text,
              password: confirmPasswordController.text,
              lastname: lastNameController.text,
              firstname: firstNameController.text,
              age: int.parse(ageController.text),
              photo: image != null ? image.toString() : '')
          .then((value) => value.fold((l) {
                isloodingFalse();
                CustomToast.showMessage(
                    message: l, messageType: MessageType.REJECTED);
              }, (r) {
                isloodingFalse();
                CustomToast.showMessage(
                    message: 'SignUp is done,please login again',
                    messageType: MessageType.REJECTED);
                Get.off(() => const LogInView());
              }));
    } else {
      isloodingFalse();
      CustomToast.showMessage(message: 'Please fill your information');
    }
  }
}
