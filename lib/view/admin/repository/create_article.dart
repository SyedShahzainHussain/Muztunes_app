import 'dart:io';

import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class CreateArticle {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future createArticleApi(
      Map<String, dynamic>? fields, File? imageFiles) async {
    try {
      await baseApiServices.getPostSingleImageFormApiResponse(
        url: Urls.articleUrl, // Replace with your API URL
        fields: fields,
        files: imageFiles,
      );
    } catch (e) {
      rethrow;
    }
  }
}
