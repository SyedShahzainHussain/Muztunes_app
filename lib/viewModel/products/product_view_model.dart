import 'package:flutter/material.dart';
import 'package:muztunes/data/response/api_response.dart';
import 'package:muztunes/model/product_model.dart';
import 'package:muztunes/repository/products/product_http_repository.dart';
import 'package:muztunes/repository/products/product_repository.dart';

class ProductViewModel with ChangeNotifier {
  final ProductRepository productRepository = ProductHttpRepository();

  String selectedImage = "";

  set setSelectedImage(String image) {
    selectedImage = image;
    notifyListeners();
    print("Selected image updated: $selectedImage");
  }

  // Todo AllProducts Method
  ApiResponse<ProductModel> allProductResponse = ApiResponse.loading();

  setAllProductAPi(ApiResponse<ProductModel> allProductResponse) {
    this.allProductResponse = allProductResponse;
    notifyListeners();
  }

  Future<ProductModel> fetchAllProducts(
      [Map<String, dynamic>? queryParameters]) async {
    try {
      final products = await productRepository.fetchAllProduct(queryParameters);
      return products;
    } catch (error) {
      // Handle errors or rethrow them as needed
      throw Exception('Failed to load products');
    }
  }

  Future<void> getAllProducts([Map<String, dynamic>? queryParameters]) async {
    setAllProductAPi(ApiResponse.loading());
    try {
      final products = await productRepository.fetchAllProduct(queryParameters);
      setAllProductAPi(ApiResponse.complete(products));
    } catch (error) {
      setAllProductAPi(ApiResponse.error(error.toString()));
    }
  }
}
