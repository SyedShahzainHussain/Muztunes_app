import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/model/get_all_orders.dart';
import 'package:muztune/model/get_stream_model.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/utils/global_context.dart';
import 'package:muztune/view/admin/repository/create_article.dart';
import 'package:muztune/view/admin/repository/create_category.dart';
import 'package:muztune/view/admin/repository/create_product.dart';
import 'package:muztune/view/admin/repository/create_stream_id.dart';
import 'package:muztune/view/admin/repository/delete_order.dart';
import 'package:muztune/view/admin/repository/delete_stream.dart';
import 'package:muztune/view/admin/repository/get_admin_orders.dart';
import 'package:muztune/view/admin/repository/get_stream_id.dart';
import 'package:muztune/view/admin/repository/put_order_type.dart';
import 'package:muztune/view/entry_point_screen.dart';
import 'package:provider/provider.dart';

class CreateProductViewModel with ChangeNotifier {
  CreateProduct createProduct = CreateProduct();
  CreateArticle createArticle = CreateArticle();
  CreateCategory createCategory = CreateCategory();
  GetAdminOrders getAdminOrders = GetAdminOrders();
  PutOrderType putOrderType = PutOrderType();
  DeleteOrder deleteOrder = DeleteOrder();
  CreateStreamId createStreamId = CreateStreamId();
  GetStreamId getStreamId = GetStreamId();
  DeleteStream deleteStream = DeleteStream();

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
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const EntryPointScreen()),
            (route) => false);
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
        context.read<BottomNavigationProvider>().setIndex(Menus.home);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const EntryPointScreen()),
            (route) => false);
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
        context.read<BottomNavigationProvider>().setIndex(Menus.home);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const EntryPointScreen()),
            (route) => false);
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

  ApiResponse<List<GetAllOrder>> getOrderList = ApiResponse.loading();

  setOrderList(ApiResponse<List<GetAllOrder>> getOrderList) {
    this.getOrderList = getOrderList;
    notifyListeners();
  }

  Future getAllAdminOrders() async {
    setOrderList(ApiResponse.loading());
    await getAdminOrders.getAdminAllOrders().then((data) {
      setOrderList(ApiResponse.complete(data));
    }).onError((error, _) {
      setOrderList(ApiResponse.error(error.toString()));
    });
  }

  bool putOrderStatusLoading = false;
  setOrderStatusLoading(bool putOrderStatusLoading) {
    this.putOrderStatusLoading = putOrderStatusLoading;
    notifyListeners();
  }

  Future putOrderTypeApi(dynamic body, String orderId) async {
    setOrderStatusLoading(true);
    await putOrderType.putOrderTypeApi(body, orderId).then((data) {
      print("Order Status Updated");
      setOrderStatusLoading(false);
    }).onError((error, _) {
      print(error);
      setOrderStatusLoading(false);
    });
  }

  bool orderDeleteLoading = false;
  setOrderDeleteLoading(bool orderDeleteLoading) {
    this.orderDeleteLoading = orderDeleteLoading;
    notifyListeners();
  }

  Future deleteOrderTypeApi(String orderId) async {
    setOrderDeleteLoading(true);
    await deleteOrder.deleteOrder(orderId).then((data) {
      ContextUtility.context
          .flushBarSuccessMessage(message: "Order has been delete");
      setOrderDeleteLoading(false);
    }).onError((error, _) {
      print(error);
      setOrderDeleteLoading(false);
    });
  }

  bool createStreamLoading = false;
  setcreateStreamLoading(bool createStreamLoading) {
    this.createStreamLoading = createStreamLoading;
    notifyListeners();
  }

  Future createStream(dynamic body, BuildContext context) async {
    setcreateStreamLoading(true);
    await createStreamId.createStreamApi(body).then((value) {
      Navigator.pop(context);
      ContextUtility.context
          .flushBarSuccessMessage(message: "Stream has been Created");
      setcreateStreamLoading(false);
    }).onError((error, _) {
      ContextUtility.context.flushBarSuccessMessage(message: error.toString());
      setcreateStreamLoading(false);
    });
  }

  ApiResponse<List<StreamModel>> getStreams = ApiResponse.loading();

  setGetStream(ApiResponse<List<StreamModel>> getStreams) {
    this.getStreams = getStreams;
    notifyListeners();
  }

  getStreamApi() async {
    setGetStream(ApiResponse.loading());
    await getStreamId.getStreamApi().then((value) {
      setGetStream(ApiResponse.complete(value));
    }).onError((error, _) {
      setGetStream(ApiResponse.error(error.toString()));
    });
  }

  bool deleteStreamLoading = false;
  setdeleteStreamLoading(bool deleteStreamLoading) {
    this.deleteStreamLoading = deleteStreamLoading;
    notifyListeners();
  }

  deleteStreamApi(String id) async {
    setdeleteStreamLoading(true);
    await deleteStream.deleteStream(id).then((value) async {
      setdeleteStreamLoading(false);
      await getStreamApi();
    }).onError((error, _) {
      setdeleteStreamLoading(false);
    });
  }
}
