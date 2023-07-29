import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealorder/core/enums/message_type.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';
import 'package:mealorder/ui/views/new_passowrd_view/new_passoword_view.dart';
import 'package:mealorder/ui/views/reset_password_view/reset_password_view.dart';
import 'package:mealorder/ui/views/new_passowrd_view/shared_cntainer_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SentCodeNewPasswordView extends StatefulWidget {
  const SentCodeNewPasswordView({Key? key}) : super(key: key);

  @override
  State<SentCodeNewPasswordView> createState() =>
      _SentCodeNewPasswordViewState();
}

class _SentCodeNewPasswordViewState extends State<SentCodeNewPasswordView> {
  final firstFoucsNode = FocusNode();

  final secoundFoucsNode = FocusNode();

  final thirdFoucsNode = FocusNode();

  final fourFoucsNode = FocusNode();
  List<int> otpCode = [2, 4, 6, 8];
  List<String> newOtpCode = [];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    bool verifictionCodeOtp = false;

    // List<Widget> otpCodeWidget=List.generate(otpCode.length, (index) =>CustomToast.showMessage(size: size, message:'This code is true thanks for you' ,messageType: MessageType.SUCCESS));
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Align(
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 18),
                child: CustomText(
                  text: 'We have Sent an OTP to',
                  fontSizeText: 30,
                  // fontWeightText: FontWeight.bold,
                  textColor: Colors.black87,
                )),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'your Mobile',
                style: TextStyle(fontSize: 36, color: Colors.black87),
              ),
            ),
            const CustomText(text: 'Please check your mobile number'),
            const CustomText(text: 'continue to reset your password'),
            Padding(
              padding: const EdgeInsets.only(left:20,right:20,top:20 ),
              child: PinCodeTextField(
                appContext: context,
                cursorColor: AppColors.mainOrangeColor,
                hintCharacter: '*',
                hintStyle: const TextStyle(fontSize:25),
                length: 4,
                obscuringCharacter:'*' ,
                obscureText: true,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: AppColors.colorTextFormField,
                    selectedFillColor: AppColors.colorTextFormField,
                    selectedColor: AppColors.colorTextFormField,
                    inactiveFillColor: AppColors.colorTextFormField,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 80,
                    fieldWidth: 80,
                    activeFillColor: AppColors.colorTextFormField,
                    inactiveColor: AppColors.colorTextFormField,
                ),
                animationDuration: const Duration(milliseconds: 300),
                // backgroundColor: Colors.white,
                enableActiveFill: true,
                onCompleted: (v) {
                  "Completed";
                },
                onChanged: (value) {
                  List<String> newOtpCodeWidget =
                      List.generate(value.length, (index) => value[index]);
                  setState(() {
                    newOtpCode = newOtpCodeWidget;
                  });
                  if (newOtpCode.toString() == otpCode.toString()) {
                    verifictionCodeOtp = true;
                    CustomToast.showMessage(
                        message: 'This code is true thanks for you',
                        messageType: MessageType.SUCCESS);
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      Get.off(const NewPasswordView());
                    });
                  } else if (newOtpCode.length == otpCode.length) {
                    verifictionCodeOtp = false;
                    CustomToast.showMessage(
                        message: 'This code is false please check it',
                        messageType: MessageType.REJECTED);
                  }
                },
                beforeTextPaste: (text) {
                  "Allowing to paste $text";
                  return true;
                },
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SharedContainerView(
            //           mainFoucsNode: firstFoucsNode,
            //           secoundFoucsNode: secoundFoucsNode),
            //       SharedContainerView(
            //         mainFoucsNode: secoundFoucsNode,
            //         secoundFoucsNode: thirdFoucsNode,
            //       ),
            //       SharedContainerView(
            //         mainFoucsNode: thirdFoucsNode,
            //         secoundFoucsNode: fourFoucsNode,
            //       ),
            //       SharedContainerView(
            //         mainFoucsNode: fourFoucsNode,
            //         secoundFoucsNode: fourFoucsNode,
            //       ),
            //     ],
            //   ),
            // ),
            ,
            CustomButton(
              text: 'Next',
              onPressed: () {
                if (verifictionCodeOtp == false) {
                  CustomToast.showMessage(
                      message: 'This code is false please check it',
                      messageType: MessageType.REJECTED);
                }
                // CustomToast.showMessage(size: size, message:controller.text);
                SharedContainerView.kee;
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) {
                //       return const NewPasswordView();
                //     }));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Didnt Receive ? ',
                  style: TextStyle(fontSize: 17),
                ),
                InkWell(
                  onTap: () {
                    Get.off(const ResetPasswordView());
                  },
                  child: Text(
                    'Click Here',
                    style: TextStyle(color: Colors.red[800]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
