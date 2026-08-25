import 'package:app_ecommerce_akshita/features/product_list/productlist_controller.dart';
import 'package:app_ecommerce_akshita/features/product_list/productlist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_functions.dart';
import '../../common/common_textfieldstyle.dart';
import '../../utils/colors.dart';
import '../product_detail/productdetail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return GetBuilder<ProductListController>(
      init: ProductListController(),
        builder: (productListController){
          return Scaffold(
              appBar : AppBar(
                title:  Text(
                  "Products",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.colorWhite,
                  ),
                ),
                centerTitle: true,
                backgroundColor: AppColors.colorPrimary,
                elevation:  0.5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
                    onPressed: () {
                      Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    },
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  productListController.refreshData();
                },
                child: Column(
                  children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                     child: searchFieldStyle(
                        "Search product...", productListController.searchController,
                        onClick: (val){
                          productListController.updateSearch(val);
                        }
                      ),
                   ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (productListController.isLoading) {
                            return Center(
                                child: SizedBox(
                                    height: 30,width: 30,
                                    child: const CircularProgressIndicator(strokeWidth: 2)));
                          }
                          if (productListController.hasError && productListController.filteredProducts.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
                                  SizedBox(height: 10),
                                  Text(productListController.errorMessage, style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () => productListController.refreshData(),
                                    child: Text("Retry"),
                                  )
                                ],
                              ),
                            );
                          }
                          if (productListController.filteredProducts.isEmpty) {
                            return emptyState();
                          }
                          return ListView.builder(
                            controller: productListController.scrollController,
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: productListController.filteredProducts.length + 1,
                            itemBuilder: (context, index) {
                              if (index == productListController.filteredProducts.length) {
                                if (productListController.isLoadMore) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: SizedBox(
                                        height: 20, width: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              }
                              final product = productListController.filteredProducts[index];
                              return productListItem(product, index);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  Widget productListItem(ProductModel product, int index) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
        Get.to(() => ProductDetailScreen(product: product));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(6, 6),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    width: 130,
                    color: AppColors.colorWhite,
                    child: Hero(
                      tag: 'product_${product.id}',
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: networkImageUrl(product.image[0], 50)
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: GetBuilder<ProductListController>(
                      builder: (productListController) {
                        bool isFav = product.isFavorite;
                        return GestureDetector(
                          onTap: () => productListController.toggleFavorite(product),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.colorWhite.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                              color: isFav ? AppColors.colorRed : AppColors.colorBlack.withOpacity(0.35),
                              size: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    color: AppColors.colorBlack,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                              product.category,
                              style: TextStyle(
                                color: AppColors.colorSuccessDarkOrange,
                                fontSize: 11,
                              )
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Qty: ${product.stock}',
                                style: TextStyle(
                                  color: AppColors.colorBlack,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
