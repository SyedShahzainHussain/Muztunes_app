import 'package:muztune/model/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel> fetchAllProduct([Map<String, dynamic>? queryParameters]);
  Future<ProductModel> fetchAllProductFromQuery(
      [Map<String, dynamic>? queryParameters]);
}
