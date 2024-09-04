import 'package:muztune/config/urls.dart';
import 'package:muztune/repository/contact/contact_repository.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class ContactHttpRepository extends ContactRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future contactPostApi(body) async {
    try {
    await  baseApiServices.getPostApiResponse(Urls.craeateContact, body);
    } catch (e) {
      rethrow;
    }
  }
}
