import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/view/admin/repository/create_article.dart';
import 'package:muztune/view/admin/repository/create_category.dart';
import 'package:muztune/view/admin/repository/create_product.dart';
import 'package:muztune/view/entry_point_screen.dart';
import 'package:provider/provider.dart';

class CreateProductViewModel with ChangeNotifier {
  CreateProduct createProduct = CreateProduct();
  CreateArticle createArticle = CreateArticle();
  CreateCategory createCategory = CreateCategory();

  bool productLoading = false;
  setProductLoading(bool loading) {
    productLoading = loading;
    notifyListeners();
  }

  Future createProductApi(Map<String, dynamic>? fields, List<File>? imageFiles,
      BuildContext context, GlobalKey<FormState> formKey) async {
    setProductLoading(true);
    await createProduct.createProductApi(fields, imageFiles).then((data) {
      formKey.currentState!.save();
      if (context.mounted) {
        context.read<BottomNavigationProvider>().setIndex(Menus.home);
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const EntryPointScreen()));
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

  bool categoryLoading = false;
  setCategoryLoading(bool loading) {
    categoryLoading = loading;
    notifyListeners();
  }

  Future createCategoryApi(dynamic body, BuildContext context) async {
    setCategoryLoading(true);
    await createCategory.createCategory(body).then((data) {
      if (context.mounted) {
        Navigator.pop(context);
        context.flushBarSuccessMessage(message: "Category Create Successfully");
      }
      setCategoryLoading(false);
    }).onError((error, _) {
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
      setCategoryLoading(false);
    });
  }
}
