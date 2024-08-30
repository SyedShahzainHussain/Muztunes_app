import 'package:muztunes_apps/config/urls.dart';
import 'package:muztunes_apps/data/network/base_api_services.dart';
import 'package:muztunes_apps/data/network/network_api_services.dart';
import 'package:muztunes_apps/model/product_model.dart';
import 'package:muztunes_apps/repository/products/product_repository.dart';

class ProductHttpRepository extends ProductRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<ProductModel> fetchAllProduct() async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.allProductsUrl);

    
      return ProductModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
