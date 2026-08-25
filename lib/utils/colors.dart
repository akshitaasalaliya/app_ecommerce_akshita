import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();

  static bool get _isDark {
    try {
      if (Get.context != null) return Get.isDarkMode;
      final dispatcher = WidgetsBinding.instance.platformDispatcher;
      return dispatcher.platformBrightness == Brightness.dark;
    } catch (e) {
      return false;
    }
  }

  static Color get colorBlack => _isDark ? Colors.white : Colors.black;
  static Color get colorWhite => _isDark ? Colors.black : Colors.white;
  static Color colorRed = Colors.red;

  static Color colorPrimary = Color(0xFF4F46E5);

  static Color colorSuccessDarkGreen = const Color(0xFF5CC489);
  static Color colorSuccessDarkOrange = const Color(0xFFFDBA74);

}
