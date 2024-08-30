import 'package:muztunes/config/urls.dart';
import 'package:muztunes/data/network/base_api_services.dart';
import 'package:muztunes/data/network/network_api_services.dart';
import 'package:muztunes/model/product_model.dart';
import 'package:muztunes/repository/products/product_repository.dart';

class ProductHttpRepository extends ProductRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<ProductModel> fetchAllProduct( [Map<String, dynamic>? queryParameters]) async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.allProductsUrl,queryParameters);

      return ProductModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
