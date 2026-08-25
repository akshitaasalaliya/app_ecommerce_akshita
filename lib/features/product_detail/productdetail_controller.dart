import 'package:app_ecommerce_akshita/features/product_list/productlist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../product_list/productlist_controller.dart';

class ProductDetailController extends GetxController {
  final ProductModel product;
  final ProductListController productListController = Get.find();

  ProductDetailController({required this.product});

  @override
  void onInit() {
    super.onInit();

  }
  void toggleFavorite() {
    productListController.toggleFavorite(product);
    update();
  }
}