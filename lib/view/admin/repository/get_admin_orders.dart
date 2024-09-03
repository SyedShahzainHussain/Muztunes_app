import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/get_all_orders.dart';

class GetAdminOrders {
  final BaseApiServices baseApiServices = NetworkApiServices();
  Future<List<GetAllOrder>> getAdminAllOrders() async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.getAllOrders);
      final data = response as List;
      return data.map((e) {
        return GetAllOrder.fromJson(e);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
