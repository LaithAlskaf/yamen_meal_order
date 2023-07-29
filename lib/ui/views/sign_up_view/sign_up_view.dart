import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealorder/core/data/repositories/user_repositiory.dart';
import 'package:mealorder/core/enums/image_file_type.dart';
import 'package:mealorder/core/translation/app_translation.dart';
import 'package:mealorder/ui/shared/colors.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_buttom.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';
import 'package:mealorder/ui/shared/extension_sizebox.dart';
import 'package:mealorder/ui/shared/utils.dart';
import 'package:mealorder/ui/views/login_view/login_view.dart';
import 'package:mealorder/ui/views/main_view/main_view.dart';
import 'package:mealorder/ui/views/sign_up_view/sign_up_controller.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _firstNameFocusEmail = FocusNode();
  final _firstNameFocusAge = FocusNode();
  final _lastNameFocusPassword = FocusNode();
  final _lastNameFocusName = FocusNode();
  final _firstNameFocusFirstName = FocusNode();
  final _lastNameFocusConfirmPassword = FocusNode();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  SignUpController controller = SignUpController();
  File? fileupload;
  File? image;
  late ImageFileType? imageOrFile;
  final imagePicker = ImagePicker();

// late bool? phototype;
  send() {
    if (formState.currentState!.validate()) {
      ('Its Ok');
      controller.isloodingTrue();
      Future.delayed(const Duration(seconds: 2)).then((value) {
        controller.isloodingFalse();
        UserRepository().register(
            email: emailController.text,
            password: confirmPasswordController.text,
            lastname: lastNameController.text,
            firstname: firstNameController.text,
            age: int.parse(ageController.text),
            photo: image != null ? image.toString() : '');
        Get.offAll(const ShoppingPageView());
      });
    } else {
      CustomToast.showMessage(message: 'Please fill your information');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isProtrate = MediaQuery.of(context).orientation;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(252, 255, 255, 1),
      body: Center(
        child: Form(
          key: formState,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: Center(
                    child: CustomText(
                  text: tr("key_signUp"),
                  fontSizeText: 36,
                  fontWeightText: FontWeight.bold,
                  textColor: AppColors.textColorLoginSign,
                )),
              ),
              Center(
                child: CustomText(
                  text: tr("key_yourDetalls"),
                  textColor: AppColors.textColormain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                      backgroundImage: image == null ? null : FileImage(image!),
                      backgroundColor: image == null && fileupload == null
                          ? AppColors.mainOrangeColor
                          : null,
                      radius: 80,
                      child: image == null || fileupload == null
                          ? InkWell(
                              onTap: image != null || fileupload != null
                                  ? null
                                  : () {
                                      image == null && fileupload == null
                                          ? dialogImage()
                                          : null;
                                    },
                              child: image != null
                                  ? null
                                  : Icon(
                                      fileupload != null
                                          ? Icons.file_copy
                                          : Icons.person,
                                      size: 120,
                                    ))
                          : null),
                  if (image != null || fileupload != null)
                    Container(
                        padding: EdgeInsets.only(
                            left: image == null && fileupload == null
                                ? screenWidth(17.6)
                                : screenWidth(5),
                            top: image == null && fileupload == null
                                ? screenWidth(10)
                                : screenWidth(3.3)),
                        child: InkWell(
                          onTap: () {
                            image == null && fileupload == null
                                ? null
                                : dialogImage();
                          },
                          child: CircleAvatar(
                              backgroundColor: AppColors.mainOrangeColor,
                              child: const Icon(
                                Icons.edit_rounded,
                                size: 27,
                              )),
                        ))
                ],
              ),
              TextFormFieldSIgnUP(
                firstNameFocus: _lastNameFocusName,
                lastNameFocus: _firstNameFocusFirstName,
                hintText: tr("key_firstName"),
                controller: firstNameController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your First Name';
                  } else if (!isValidName(text)) {
                    return 'First Name is not valid';
                  }
                  return null;
                },
              ),
              TextFormFieldSIgnUP(
                firstNameFocus: _firstNameFocusFirstName,
                lastNameFocus: _firstNameFocusEmail,
                hintText: tr("key_lastName"),
                controller: lastNameController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your Last Name';
                  } else if (!isValidName(text)) {
                    return 'Last Name is not valid';
                  }
                  return null;
                },
              ),
              TextFormFieldSIgnUP(
                firstNameFocus: _firstNameFocusEmail,
                lastNameFocus: _firstNameFocusAge,
                hintText: tr("key_yourEmail"),
                controller: emailController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your Email';
                  } else if (!isEmail(text)) {
                    return 'Email is not valid';
                  }
                  return null;
                },
              ),
              TextFormFieldSIgnUP(
                firstNameFocus: _firstNameFocusAge,
                lastNameFocus: _lastNameFocusPassword,
                hintText: tr("key_age"),
                textType: TextInputType.number,
                controller: ageController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your Age';
                  } else if (!checkAge(text)) {
                    return 'Age is not correct';
                  }
                  return null;
                },
              ),
              TextFormFieldSIgnUP(
                firstNameFocus: _lastNameFocusPassword,
                lastNameFocus: _lastNameFocusConfirmPassword,
                hintText: tr("key_password"),
                controller: passwordController,
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
                hintText: tr("key_confirmPassword"),
                controller: confirmPasswordController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Your Confirm Password';
                  } else if (!isValidPassword(passwordController.text,
                      confirmPasswordController.text)) {
                    return 'Confirm Password is not valid';
                  }
                  return null;
                },
              ),
              Obx(
                () => controller.islooding.isTrue
                    ? SpinKitCircle(
                        color: AppColors.mainOrangeColor,
                        size: 25.w,
                      )
                    : CustomButton(
                        text: tr("key_signUp"),
                        paddingElevatedVertical: 2.h,
                        onPressed: () {
                          send();
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: tr("key_alreadyHaveAccount"),
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(const LogInView());
                        },
                        child: CustomText(
                          text: tr("key_login"),
                          textColor: AppColors.mainOrangeColor,
                        )),
                  ],
                ),
              ),
              8.ph,
            ],
          ),
        ),
      ),
    ));
  }

  dialogImage() {
    AwesomeDialog(
      showCloseIcon: true,
      btnOkText: 'Camera',
      borderSide: BorderSide(
        color: AppColors.mainOrangeColor,
        width: 2,
      ),
      width: screenWidth(1),
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      btnCancelText: 'gallery',
      body: Column(
        children: [
          const Text(
            'Upload Image Or File',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          if (image != null || fileupload != null) ...[
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    image = null;
                    fileupload = null;
                    Navigator.pop(context);
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    Text(
                      'To remove the image click here.',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ],
          const SizedBox(
            height: 10,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            radius: 10,
            onTap: () {
              uploadImageOrFile(ImageFileType.FILE);
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.file_copy_rounded,
                  color: Colors.red,
                ),
                Text(
                  'select file',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
      btnOkIcon: Icons.camera_alt_outlined,
      btnCancelIcon: Icons.photo_library_outlined,
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: 'Upload Image',
      desc: 'Upload Image ........',
      btnCancelOnPress: () {
        setState(() {
          // phototype = true;
        });
        uploadImageOrFile(ImageFileType.GALLERY);
      },
      btnOkOnPress: () {
        setState(() {
          // phototype = false;
        });
        uploadImageOrFile(ImageFileType.CAMERA);
      },
    ).show();
  }

  uploadImageOrFile(ImageFileType type) async {
    late var pickedType;
    switch (type) {
      case ImageFileType.FILE:
        pickedType = await FilePicker.platform.pickFiles();
        setState(() {
          fileupload = File(pickedType.files.single.path.toString());
          image = null;
        });
        break;
      case ImageFileType.GALLERY:
        pickedType = await imagePicker.getImage(source: ImageSource.gallery);
        setState(() {
          image = File(pickedType.path);
          // phototype = true;
        });
        break;
      case ImageFileType.CAMERA:
        pickedType = await imagePicker.getImage(source: ImageSource.camera);
        setState(() {
          image = File(pickedType.path);
          // phototype = false;
        });
        break;
    }
  }
}


