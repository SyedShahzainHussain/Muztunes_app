import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/category_model.dart';
import 'package:muztune/repository/category/category_repository.dart';

class CategoryHttpRepository extends CategoryRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.categoryUrl);
      final data = response as List;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
