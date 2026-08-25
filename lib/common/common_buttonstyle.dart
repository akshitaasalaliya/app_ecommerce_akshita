import 'package:app_ecommerce_akshita/utils/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget loginButtonStyle(String stTitle, {required Function onTap}){
  return GestureDetector(
    onTap: (){
      onTap.call();
    },
    child: Container(
      margin: EdgeInsetsGeometry.symmetric(vertical: 10),
      padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.colorPrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Text(stTitle, style: TextStyle(
        fontSize: 18, color: AppColors.colorWhite, fontWeight: FontWeight.w700
      )),
    ),
  );
}