import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/app/my_app.dart';
import 'package:mealorder/core/data/repositories/user_repositiory.dart';
import 'package:mealorder/core/enums/message_type.dart';
import 'package:mealorder/core/services/base_controller.dart';
import 'package:mealorder/core/translation/app_translation.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';
import 'package:mealorder/ui/shared/extension_sizebox.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/login_view/login_controller.dart';
import 'package:mealorder/ui/views/main_view/main_view.dart';
import 'package:mealorder/ui/views/reset_password_view/reset_password_view.dart';
import 'package:mealorder/ui/views/sign_up_view/sign_up_view.dart';
import 'package:sizer/sizer.dart';

import '../map_view/map_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {

  LoginController controller = Get.put(LoginController());
  // BaseController controllerBase = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.textColor,
          body: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 4.h, bottom: 1.h),
                      child: CustomText(
                        text: tr('key_login'),
                        fontSizeText: 30.sp,
                        fontWeightText: FontWeight.bold,
                        textColor: AppColors.textColorLoginSign,
                      )),
                  CustomText(
                    text: tr('key_yourDetalls'),
                  ),
                  TextFormFieldSIgnUP(
                    firstNameFocus:controller.firstNameFocusEmail,
                    lastNameFocus: controller.lastNameFocuspassword,
                    controller: controller.emailController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter your email';
                      } else if (!isEmail(text)) {
                        return 'Email is not valid';
                      }
                      return null;
                    },
                    hintText: tr("key_yourEmail"),
                  ),
                  TextFormFieldSIgnUP(
                    firstNameFocus: controller.lastNameFocuspassword,
                    hintText: tr("key_password"),
                    obscureTextBollean: true,
                    controller: controller.passwordController,
                    // validator: (text) {
                    //   if (text == null || text.isEmpty) {
                    //     return 'Please check your password';
                    //   } else if (!validatePassword(text)) {
                    //     return 'Password is not valid';
                    //   }
                    //   return null;
                    // },
                  ),
                  // Obx(() =>  controller.isLoading.isTrue
                  //     ? SpinKitCircle(
                  //   color: AppColors.mainOrangeColor,
                  //   size: 22.w,
                  // )
                  //     :
                  CustomButton(
                    text: tr('key_login'),
                    onPressed: () {
                      Get.to(MapView());
                      // controller.runFullLoadingFutureFunction(
                      //     function: UserRepository()
                      //     .login(
                      //     email: controller.emailController.text,
                      //     password: controller.passwordController.text)
                      //     .then((value) {
                      //   value.fold((l) {
                      //     controller.isloodingFalse();
                      //     CustomToast.showMessage(
                      //         messageType: MessageType.REJECTED,
                      //         message: l);
                      //   }, (r) {
                      //     storage.setTokenIno(r);
                      //     Get.offAll(const ShoppingPageView());
                      //   });
                      // }) );
                      controller.login();
                      },
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(const ResetPasswordView());
                      },
                      child: CustomText(
                        text: tr("key_forgetPassword"),
                        textColor: AppColors.textColormain,
                        fontSizeText: 12.sp,
                      )),
                  20.ph,
                  CustomText(
                    text: tr("key_OrLoginWith"),
                    fontSizeText: 12.sp,
                  ),
                  CustomButton(
                    text: 'Login with Facebook',
                    backgroundColor: Colors.blue[800],
                    imageName: 'Facebook',
                  ),
                  CustomButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: tr("key_changeLanguage"),
                          content: Column(children: [
                            InkWell(onTap: () {
                              storage.setAppLanguage('en');
                              Get.updateLocale(getLocal());
                              Get.back();
                            }, child: const Text('English'),),
                            InkWell(onTap: () {
                              storage.setAppLanguage('ar');
                              Get.updateLocale(getLocal());
                              Get.back();
                            }, child: const Text('العربية'),),
                            InkWell(onTap: () {
                              storage.setAppLanguage('tr');
                              Get.updateLocale(getLocal());
                              Get.back();
                            }, child: const Text('Tricish'),),
                          ],)
                      );
                    },
                    text: 'Login with Google',
                    backgroundColor: Colors.red[600],
                    paddingElevatedVertical: 0,
                    imageName: 'google-plus-logo',
                  ),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: tr("key_dontHaveAccount"),
                        fontSizeText: 14.sp,
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(const SignUpView());
                          },
                          child: CustomText(
                            text: tr("key_signUp"),
                            textColor: AppColors.mainOrangeColor,
                          )),
                    ],
                  ),
                  8.ph,
                ],
              ),
            ),
          ),
        ));
  }
}

//
// {
// setState(() {
// isLoading = true;
// });
// UserRepository()
//     .login(
// email: emailController.text,
// password: passwordController.text)
// .then((value) {
// value.fold((l) {
// setState(() {
// isLoading = false;
// });
//
// CustomToast.showMessage(
// messageType: MessageType.REJECTED,
// size: size,
// message: l);
// }, (r) {
// SharedPrefrenceRepository.setTokenIno(r);
// //SharedPrefrenceRepository.setLoggedIn(true);
// Navigator.pushReplacement(context,
// MaterialPageRoute(
// builder: (context) {
// return MainView();
// },
// ));
// });
// });
// }
