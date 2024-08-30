import 'package:muztunes_apps/model/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel> fetchAllProduct();
}
