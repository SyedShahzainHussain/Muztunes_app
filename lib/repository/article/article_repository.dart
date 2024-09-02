import 'package:muztune/model/article_model.dart';

abstract class ArticleRepository {
  Future<ArticleModel> getArticle();
}
