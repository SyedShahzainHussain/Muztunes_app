import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class DeleteOrder {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future deleteOrder(String id) async {
    try {
      await baseApiServices.deletePostApiResponse("${Urls.placeOrder}/$id");
    } catch (e) {
      rethrow;
    }
  }
}
