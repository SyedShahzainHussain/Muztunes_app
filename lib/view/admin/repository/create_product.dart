import 'dart:io';

import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class CreateProduct {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future createProductApi(
      Map<String, dynamic>? fields, List<File>? imageFiles) async {
    try {
      await baseApiServices.getPostFormApiResponse(
        url: Urls.createProduct, // Replace with your API URL
        fields: fields,
        files: imageFiles,
      );
    } catch (e) {
      rethrow;
    }
  }
}
