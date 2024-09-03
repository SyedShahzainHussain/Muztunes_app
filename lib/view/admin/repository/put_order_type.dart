import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/network_api_services.dart';

class PutOrderType {
  final BaseApiServices baseApiServices = NetworkApiServices();
  Future<void> putOrderTypeApi(dynamic body, String orderId) async {
    try {
      await baseApiServices.putPostApiResponse(
          "${Urls.updateOrderStatus}/$orderId", body);
    } catch (e) {
      rethrow;
    }
  }
}
