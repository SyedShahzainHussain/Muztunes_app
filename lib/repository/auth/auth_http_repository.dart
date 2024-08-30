import 'package:muztunes/config/urls.dart';
import 'package:muztunes/data/network/base_api_services.dart';
import 'package:muztunes/data/network/network_api_services.dart';
import 'package:muztunes/repository/auth/auth_repository.dart';

class AuthHttpRepository extends AuthRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future loginUser(dynamic body) async {
    try {
      final response =
          await baseApiServices.getPostApiResponse(Urls.loginUrl, body);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future registerUser(dynamic body) async {
    try {
      final response =
          await baseApiServices.getPostApiResponse(Urls.registerUrl, body);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future forgetPassword(body) async {
    try {
      final response = await baseApiServices.getPostApiResponse(
          Urls.forgotPasswordUrl, body);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future resetPassword(body) async {
    try {
      final response =
          await baseApiServices.getPostApiResponse(Urls.resetPasswordUrl, body);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
