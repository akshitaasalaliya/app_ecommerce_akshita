import 'package:app_ecommerce_akshita/features/splash/splash_screen.dart';
import 'package:app_ecommerce_akshita/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/splash/splash_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary, brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
