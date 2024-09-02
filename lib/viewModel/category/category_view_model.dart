import 'package:flutter/material.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/model/category_model.dart';
import 'package:muztune/repository/category/category_http_repository.dart';
import 'package:muztune/repository/category/category_repository.dart';

class CategoryViewModel with ChangeNotifier {
  CategoryModel? category;

  set setCategory(CategoryModel? category) {
    this.category = category;
    notifyListeners();
  }

  final CategoryRepository categoryRepository = CategoryHttpRepository();
  ApiResponse<List<CategoryModel>> categoryList = ApiResponse.loading();

  setCategoryResponse(ApiResponse<List<CategoryModel>> categoryList) {
    this.categoryList = categoryList;
    notifyListeners();
  }

  void getCategory() async {
    setCategoryResponse(ApiResponse.loading());
    await categoryRepository.getAllCategory().then((data) {
      setCategoryResponse(ApiResponse.complete(data));
    }).onError((error, _) {
      setCategoryResponse(ApiResponse.error(error.toString()));
    });
  }
}
