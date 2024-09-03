import 'package:flutter/foundation.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/model/order_model.dart';
import 'package:muztune/repository/orders/order_http_repository.dart';
import 'package:muztune/repository/orders/order_repository.dart';

class OrderViewModel with ChangeNotifier {
  final OrderRepository orderRepository = OrderHttpRepository();

  ApiResponse<List<OrderModel>> allOrderList = ApiResponse.loading();

  setOrderList(ApiResponse<List<OrderModel>> allOrderList) {
    this.allOrderList = allOrderList;
    notifyListeners();
  }

  getAllOrders() async {
    setOrderList(ApiResponse.loading());
    await orderRepository.getAllOrders().then((data) {
      if (kDebugMode) {
        print(data);
      }
      setOrderList(ApiResponse.complete(data));
    }).onError((error, _) {
      setOrderList(ApiResponse.error(error.toString()));
    });
  }

  bool placeOrderloading = false;
  setPlaceOrderLoading(bool loading) {
    placeOrderloading = loading;
    notifyListeners();
  }

  placeOrdersApi() async {
    setPlaceOrderLoading(true);
    await orderRepository.placeOrdersApi().then((data) {
      setPlaceOrderLoading(false);
      if (kDebugMode) {
        print("Order Place");
      }
    }).onError((error, _) {
      if (kDebugMode) {
        print(error);
      }
      setPlaceOrderLoading(false);
    });
  }
}
