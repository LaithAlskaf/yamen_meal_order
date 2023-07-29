import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/data/repositories/user_repositiory.dart';
import 'package:mealorder/core/enums/message_type.dart';
import 'package:mealorder/core/services/base_controller.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/main_view/main_view.dart';

class LoginController extends BaseController{
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  final firstNameFocusEmail = FocusNode();
  final lastNameFocuspassword = FocusNode();



  RxBool  isLoading = false.obs;
  isloodingTrue(){
    isLoading.value=true;
  }
  isloodingFalse(){
    isLoading.value=false;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      runFullLoadingFutureFunction(
        function: UserRepository()
            .login(
            email: emailController.text, password: passwordController.text)
            .then((value) {
          value.fold((l) {
            CustomToast.showMessage(message: l, messageType: MessageType.REJECTED);
          }, (r) {
            storage.setLoggedIN(true);
            storage.setTokenIno(r);
            Get.off(const ShoppingPageView(), transition: Transition.cupertino);
          });
        }));
    } else {}
  }
}

// void cupertinoTransition(Widget view) {
//   Get.off(view, transition: Transition.cupertino);
// }
