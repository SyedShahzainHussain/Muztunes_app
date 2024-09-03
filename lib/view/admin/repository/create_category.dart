import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class CreateCategory {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future createCategory(dynamic body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.category, body);
    } catch (e) {
      rethrow;
    }
  }
}
