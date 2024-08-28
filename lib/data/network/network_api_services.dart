import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:muztunes_apps/data/app_exception.dart';
import 'package:muztunes_apps/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw response.body.toString();
      case 500:
        throw response.body.toString();
      case 401:
      case 404:
        throw response.body.toString();
      default:
        throw FetchDataException(
            'Error occured while communicate with serverwith status code${response.statusCode}');
    }
  }
}
