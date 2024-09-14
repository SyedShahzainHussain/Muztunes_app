import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class DeleteStream {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future<void> deleteStream(String id) async {
    try {
      await baseApiServices.deletePostApiResponse("${Urls.craeateStream}/$id");
    } catch (e) {
      rethrow;
    }
  }
}
