import 'package:app_ecommerce_akshita/features/login/login_controller.dart';
import 'package:app_ecommerce_akshita/utils/colors.dart';
import 'package:app_ecommerce_akshita/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_buttonstyle.dart';
import '../../common/common_textfieldstyle.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (loginController){
          return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: loginController.loginFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.size.width * 0.1),
                          Image.asset(AppImages.icEcomerce, height: 200, width: 200),
                          SizedBox(height: Get.size.width * 0.05),
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.colorBlack),
                          ),
                          SizedBox(height: Get.size.width * 0.1),
                          textFormFieldStyle('UserName', loginController.usernameController, TextInputType.emailAddress,
                          stSuffix: SizedBox(width: 5,height: 5,),
                              onClick: (value){
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          }),
                          SizedBox(height: Get.size.width * 0.1),
                          textFormFieldStyle('Password', loginController.passwordController, TextInputType.text,
                              isObscureText: loginController.isPasswordVisible,
                              isSuffix: true,
                              stSuffix: GestureDetector(
                                onTap: (){
                                  loginController.passwordVisibility();
                                },
                                child: Icon(loginController.isPasswordVisible ? Icons.visibility_off : Icons.visibility ),
                              ),
                              onClick: (value){
                                if (value!.isEmpty ) {
                                  return 'Enter a valid password!';
                                }
                                return null;
                              }),
                          SizedBox(height: Get.size.width * 0.1),
                          loginButtonStyle("Login",
                            onTap: (){
                              loginController.onLoginButtonClick();
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        }
    );
  }
}
