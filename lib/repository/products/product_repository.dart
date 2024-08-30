import 'package:muztunes/model/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel> fetchAllProduct( [Map<String, dynamic>? queryParameters]);
}
