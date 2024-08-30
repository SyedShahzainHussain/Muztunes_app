import 'package:muztunes/config/urls.dart';
import 'package:muztunes/data/network/base_api_services.dart';
import 'package:muztunes/data/network/network_api_services.dart';
import 'package:muztunes/repository/cart/cart_repository.dart';
import 'package:muztunes/viewModel/services/session_controller/session_controller.dart';

class CartHttpRepository extends CartRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future addToCart(dynamic body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.cartPostUrl, body, {
        "Authorization": SessionController().userModel.token!,
        'Content-Type': 'application/json; charset=UTF-8',
      });
    } catch (e) {
      rethrow;
    }
  }
}
