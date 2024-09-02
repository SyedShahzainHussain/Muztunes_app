import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/view/admin/repository/create_article.dart';
import 'package:muztune/view/admin/repository/create_product.dart';

class CreateProductViewModel with ChangeNotifier {
  CreateProduct createProduct = CreateProduct();
  CreateArticle createArticle = CreateArticle();

  bool productLoading = false;
  setProductLoading(bool loading) {
    productLoading = loading;
    notifyListeners();
  }

  Future createProductApi(Map<String, dynamic>? fields, List<File>? imageFiles,
      BuildContext context) async {
    setProductLoading(true);
    await createProduct.createProductApi(fields, imageFiles).then((data) {
      if (context.mounted) {
        context.flushBarSuccessMessage(message: "Product Create Successfully");
      }
      setProductLoading(false);
    }).onError((error, _) {
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
      setProductLoading(false);
    });
  }

  bool articleLoading = false;
  setArticleLoading(bool loading) {
    articleLoading = loading;
    notifyListeners();
  }

  Future createArticleApi(Map<String, dynamic>? fields, File? imageFiles,
      BuildContext context) async {
    setArticleLoading(true);
    await createArticle.createArticleApi(fields, imageFiles).then((data) {
      if (context.mounted) {
        context.flushBarSuccessMessage(message: "Article Create Successfully");
      }
      setArticleLoading(false);
    }).onError((error, _) {
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
      setArticleLoading(false);
    });
  }
}
