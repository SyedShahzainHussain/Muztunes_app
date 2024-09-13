import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class CreateStreamId {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future createStreamApi(dynamic body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.craeateStream, body);
    } catch (e) {
      rethrow;
    }
  }
}
