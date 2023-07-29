import 'package:get/get.dart';

class SignUpController extends GetxController{
  RxBool  islooding = false.obs;
  isloodingTrue(){
    islooding.value=true;
  }
  isloodingFalse(){
    islooding.value=false;
  }
}