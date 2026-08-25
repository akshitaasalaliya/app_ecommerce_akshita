import 'package:app_ecommerce_akshita/features/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (splashController){
          return Scaffold(
            body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Image.asset(AppImages.icEcomerce, height: 200, width: 200)),
                       SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                )
            )
          );
        }
    );
  }
}
