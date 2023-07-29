import 'package:get/get.dart';
import 'package:mealorder/ui/shared/custom_widget/custom_toast.dart';

class ProdactViewcontroller extends GetxController {

  RxInt numberOfProdact=1.obs;
  int price=750;
  RxInt priceOfProdactOfTotal=750.obs;

  void increment(){
    numberOfProdact++;
  }
  void deincrement(){
    if(numberOfProdact>1)
    numberOfProdact--;
    else{
      CustomToast.showMessage(message: 'Cant deincrement');
    }
  }
  int PriceOfProdact(){
   return  priceOfProdactOfTotal.value = numberOfProdact.value * price;
  }

}