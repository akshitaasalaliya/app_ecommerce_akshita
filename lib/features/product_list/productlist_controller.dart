import 'package:app_ecommerce_akshita/features/product_list/productlist_model.dart';
import 'package:app_ecommerce_akshita/core/database/database_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/RepositoryConstants.dart';

class ProductListController extends GetxController {

  TextEditingController searchController = TextEditingController();

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  Dio dio = Dio();
  
  bool isLoading = false;
  bool isLoadMore = false;
  bool hasMoreData = true;
  bool hasError = false;
  String errorMessage = "";
  
  int limit = 10;
  int skip = 0;

  String searchQuery = '';
  
  ScrollController scrollController = ScrollController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (hasMoreData && !isLoading && !isLoadMore && searchQuery.isEmpty) {
          loadMoreData();
        }
      }
    });
    
    getProductsData(isRefresh: true);
  }

  Future<void> getProductsData({bool isRefresh = false}) async {
    if (isRefresh) {
      isLoading = true;
      skip = 0;
      hasMoreData = true;
      products.clear();
      filteredProducts.clear();
      hasError = false;
      errorMessage = "";
      update();
    } else {
      isLoadMore = true;
      update();
    }

    try {
      bool hasInternet = await _checkInternetConnection();
      
      if (hasInternet) {
        String url = 'https://dummyjson.com/products?limit=$limit&skip=$skip';

        final response = await dio.get(url);
        var responseData = response.data;
        List arrData = responseData[RepositoryConstants.products];
        
        if (arrData.length < limit) {
          hasMoreData = false;
        }

        List<ProductModel> fetchedProducts = [];
        for (var singleUser in arrData) {
          int id = singleUser[RepositoryConstants.id] ?? 0;
          ProductModel product = ProductModel(
            id: id,
            name: singleUser[RepositoryConstants.title] ?? '',
            description: singleUser[RepositoryConstants.description] ?? '',
            image: singleUser[RepositoryConstants.images] ?? [],
            price: (singleUser[RepositoryConstants.price] as num?)?.toDouble() ?? 0.0,
            stock: singleUser[RepositoryConstants.stock] ?? 0,
            category: singleUser[RepositoryConstants.category] ?? '',
            rating: (singleUser[RepositoryConstants.rating] as num?)?.toDouble() ?? 0.0,
            quantity: singleUser[RepositoryConstants.minimumOrderQuantity] ?? 1,
          );
          fetchedProducts.add(product);
        }
        
        await dbHelper.insertProducts(fetchedProducts);
      }

      /// Load from SQLite
      List<ProductModel> localProducts = await dbHelper.getProducts(limit: limit, offset: skip);
      
      if (localProducts.isEmpty && !hasInternet) {
        hasError = true;
        errorMessage = "No Internet Connection & No Offline Data";
      } else {
        if (isRefresh) {
          products.clear();
        }
        products.addAll(localProducts);
        
        if (localProducts.length < limit && !hasInternet) {
           hasMoreData = false;
        }
        
        hasError = false;
        errorMessage = "";
      }

      applyFilters();
    } on DioException catch (e) {
      if (products.isEmpty) {
        hasError = true;
        if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
          errorMessage = "API Timeout. Please try again.";
        } else if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.unknown) {
          errorMessage = "No Internet Connection";
        } else {
          errorMessage = "Something went wrong. Please try again.";
        }
      }
      debugPrint("Error fetching products: $e");
    } catch (e) {
      if (products.isEmpty) {
        hasError = true;
        errorMessage = "An unexpected error occurred.";
      }
      debugPrint("Error fetching products: $e");
    } finally {
      isLoading = false;
      isLoadMore = false;
      update();
    }
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final response = await dio.get('https://www.google.com');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void toggleFavorite(ProductModel product) async {
    product.isFavorite = !product.isFavorite;
    await dbHelper.updateProduct(product);
    update();
  }

  void loadMoreData() {
    skip += limit;
    getProductsData(isRefresh: false);
  }

  void updateSearch(String query) {
    searchQuery = query;
    applyFilters();
  }

  void applyFilters() {
    if (searchQuery.trim().isEmpty) {
      filteredProducts = products.toList();
    } else {
      filteredProducts = products.where((p) => 
        p.name.toLowerCase().contains(searchQuery.toLowerCase()) || 
        p.category.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    update();
  }

  void refreshData() {
    searchController.text = '';
    searchQuery = '';
    getProductsData(isRefresh: true);
  }
}