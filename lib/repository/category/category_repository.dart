import 'package:muztunes/model/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getAllCategory();
}
