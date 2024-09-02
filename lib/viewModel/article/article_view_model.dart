import 'package:flutter/material.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/model/article_model.dart';
import 'package:muztune/repository/article/article_http_repository.dart';
import 'package:muztune/repository/article/article_repository.dart';

class ArticleViewModel with ChangeNotifier {
  final ArticleRepository articleRepository = ArticleHttpRepository();

  ApiResponse<ArticleModel> articleList = ApiResponse.loading();

  setArticleList(ApiResponse<ArticleModel> articleList) {
    this.articleList = articleList;
    notifyListeners();
  }

  Future<void> getArticleList() async {
    setArticleList(ApiResponse.loading());
    articleRepository.getArticle().then((data) {
      setArticleList(ApiResponse.complete(data));
    }).onError((error, _) {
      setArticleList(ApiResponse.error(error.toString()));
    });
  }
}
