import 'package:muztune/model/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getAllOrders();
  Future placeOrdersApi();
}
