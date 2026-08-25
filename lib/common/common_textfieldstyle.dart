import 'package:flutter/material.dart';
import '../utils/colors.dart';

Widget textFormFieldStyle(String stLabelText, TextEditingController stController,
    TextInputType stInputType, {required Function onClick, bool isObscureText = false, bool isSuffix = false, Widget? stSuffix}){
  return  TextFormField(
    controller: stController,
    obscureText: isObscureText,
    decoration: InputDecoration(
        labelText: stLabelText,
      suffix: isSuffix ? stSuffix : SizedBox(height: 15, width: 15)
    ),
    keyboardType: stInputType,
    validator: (value) {
      return onClick.call(value);
    },
  );
}


Widget searchFieldStyle(String stHint, TextEditingController stController,{required Function onClick} ) {
  return Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.colorPrimary.withOpacity(0.08)),
          ),
          child: TextField(
            controller: stController,
            onChanged: (value){
              onClick.call(value);
            },
            style: TextStyle(fontSize: 14, color: AppColors.colorBlack),
            decoration: InputDecoration(
              hintText: stHint,
              hintStyle: TextStyle(color: AppColors.colorBlack.withOpacity(0.7), fontSize: 13),
              prefixIcon: Icon(Icons.search_rounded, color: AppColors.colorBlack, size: 18),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        );

}
