import 'package:app_ecommerce_akshita/features/product_list/productlist_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../common/common_functions.dart';
import '../../utils/colors.dart';
import 'productdetail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);


    return Scaffold(
      appBar : AppBar(
        title:  Text(
          "Product Detail",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.colorWhite,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.colorWhite),
        backgroundColor: AppColors.colorPrimary,
        elevation:  0.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          GetBuilder<ProductDetailController>(
            builder: (controller) {
              bool isFav = controller.product.isFavorite;
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                  color: isFav ? AppColors.colorRed : AppColors.colorWhite,
                ),
                onPressed: () => controller.toggleFavorite(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
          child: GetBuilder<ProductDetailController>(
            init: ProductDetailController(product: product) ,
          builder: (productDetailController){
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                color: AppColors.colorBlack.withOpacity(0.1),
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 60),
                child: networkImageUrl(product.image[0], 200),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.colorSuccessDarkGreen),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Text(
                product.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              )),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category : ${product.category}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Stock : ${product.stock.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      })),
    );
  }
}
