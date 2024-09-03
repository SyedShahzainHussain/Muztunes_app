import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/order_model.dart';
import 'package:muztune/repository/orders/order_repository.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';

class OrderHttpRepository extends OrderRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final response = await baseApiServices.getGetApiResponse(Urls.orderUrls,
          {}, {"Authorization": SessionController().userModel.token!});
      final data = response as List;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> placeOrdersApi() async {
    try {
      await baseApiServices.getPostEmptyBodyApiResponse(Urls.placeOrder);
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
