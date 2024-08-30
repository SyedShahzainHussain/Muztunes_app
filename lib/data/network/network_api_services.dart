import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:muztunes/data/app_exception.dart';
import 'package:muztunes/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url,
      [Map<String, dynamic>? queryParameters]) async {
    dynamic responseJson;
    try {
      final response = await get(
        Uri.parse(url).replace(queryParameters: queryParameters),
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic body,
      [Map<String, String>? headers]) async {
    dynamic responseJson;
    try {
      final response = await post(Uri.parse(url), body: body, headers: headers)
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
      case 201:
        print(response.body);
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw response.body.toString();
      case 500:
        throw response.body.toString();
      case 401:
      case 404:
      case 403:
        throw response.body.toString();
      default:
        throw FetchDataException(
            'Error occured while communicate with serverwith status code${response.statusCode}');
    }
  }
}
