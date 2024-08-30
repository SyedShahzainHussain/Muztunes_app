import 'package:flutter/material.dart';
import 'package:muztunes_apps/data/response/api_response.dart';
import 'package:muztunes_apps/model/product_model.dart';
import 'package:muztunes_apps/repository/products/product_http_repository.dart';
import 'package:muztunes_apps/repository/products/product_repository.dart';

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

  Future<void> getAllProducts() async {
    setAllProductAPi(ApiResponse.loading());
    try {
      final products = await productRepository.fetchAllProduct();
      setAllProductAPi(ApiResponse.complete(products));
    } catch (error) {
      setAllProductAPi(ApiResponse.error(error.toString()));
    }
  }
}
