import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/article_model.dart';
import 'package:muztune/repository/article/article_repository.dart';

class ArticleHttpRepository extends ArticleRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<ArticleModel> getArticle() async {
    try {
      final response = await baseApiServices.getGetApiResponse(Urls.articleUrl);
      return ArticleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
