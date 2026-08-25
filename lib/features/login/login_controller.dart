import 'package:app_ecommerce_akshita/common/common_functions.dart';
import 'package:app_ecommerce_akshita/features/product_list/productlist_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController{

  var loginFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isRememberMe = false;
  bool isLoading = false;
  bool isPasswordVisible = false;


  void onLoginButtonClick(){

    debugPrint("validate");
    final validate = loginFormKey.currentState!.validate() ?? false;
    if(validate){
      hideKeyboard();
      Get.offAll(() => ProductListScreen());
    } else {
      return;
    }
  }

  void passwordVisibility(){
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.text = "";
    passwordController.text = "";
  }

}