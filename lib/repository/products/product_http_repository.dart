import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/product_model.dart';
import 'package:muztune/repository/products/product_repository.dart';

class ProductHttpRepository extends ProductRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<ProductModel> fetchAllProduct(
      [Map<String, dynamic>? queryParameters]) async {
    try {
      final response = await baseApiServices.getGetApiResponse(
          Urls.allProductsUrl, queryParameters);

      return ProductModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> fetchAllProductFromQuery(
      [Map<String, dynamic>? queryParameters]) async {
    try {
      final response = await baseApiServices.getGetApiResponse(
          Urls.allProductsUrl, queryParameters);

      return ProductModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
