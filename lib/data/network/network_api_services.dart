import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:muztune/data/app_exception.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/interceptor_service.dart';

class NetworkApiServices extends BaseApiServices {
  final Dio _dio;

  NetworkApiServices() : _dio = Dio() {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future getGetApiResponse(
    String url, [
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic body,
  ]) async {
    dynamic responseJson;
    try {
      final response = await _dio.get(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic body,
      [Map<String, dynamic>? headers]) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPutFormApiResponse({
    required String url,
    Map<String, dynamic>? fields,
    File? file, // Optional single file
    bool isSingleFile = true,
    List<File>? files, // Optional multiple files
    Map<String, dynamic>? headers,
  }) async {
    dynamic returnReponse;
    try {
      var formData = FormData();

      // Add fields to form data
      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add single file
      if (isSingleFile == true && file != null) {
        String contentType = lookupMimeType(file.path) ?? 'image/jpeg';
        formData.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(file.path,
              contentType: MediaType.parse(contentType)),
        ));
      }

      // Add multiple files
      if (!isSingleFile && files != null) {
        for (var file in files) {
          String contentType = lookupMimeType(file.path) ?? 'image/jpeg';
          formData.files.add(MapEntry(
            'images[]', // Use the same key if you want to handle multiple files with the same field name
            MultipartFile.fromFileSync(file.path,
                contentType: MediaType.parse(contentType)),
          ));
        }
      }

      // Send the request
      final response = await _dio.put(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      returnReponse = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return returnReponse;
  }

  @override
  Future<dynamic> getPostFormApiResponse({
    required String url,
    Map<String, dynamic>? fields,
    List<File>? files, // List of multiple files
    Map<String, dynamic>? headers,
  }) async {
    dynamic returnReponse;
    try {
      var formData = FormData();

      // Add fields to form data
      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add multiple files
      if (files != null) {
        for (var file in files) {
          String contentType = lookupMimeType(file.path) ?? 'image/jpeg';
          formData.files.add(MapEntry(
            'images', // Adjust this field name as needed
            MultipartFile.fromFileSync(file.path,
                contentType: MediaType.parse(contentType)),
          ));
        }
      }

      // Optional: add headers if provided
      Options options = Options(
        headers: headers,
      );

      // Send the request
      final response = await _dio.post(
        url,
        data: formData,
        options: options,
      );

      returnReponse = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return returnReponse;
  }

  @override
  Future deletePostApiResponse(String url, dynamic body,
      [Map<String, dynamic>? headers]) async {
    dynamic returnReponse;
    try {
      final response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: headers),
      );
      returnReponse = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return returnReponse;
  }

  @override
  Future putPostApiResponse(String url, body,
      [Map<String, String>? headers]) async {
    dynamic responseJson;
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostSingleImageFormApiResponse(
      {required String url,
      Map<String, dynamic>? fields,
      File? files,
      Map<String, dynamic>? headers}) async {
    dynamic returnReponse;
    try {
      var formData = FormData();

      // Add fields to form data
      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add single file
      String contentType = lookupMimeType(files!.path) ?? 'image/jpeg';
      formData.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(files.path,
            contentType: MediaType.parse(contentType)),
      ));

      // Send the request
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      returnReponse = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return returnReponse;
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
        // Extract message from response body if available
        String errorMessage = response.data['message'] ??
            response.statusMessage ??
            'An error occurred';
        throw errorMessage;
      default:
        throw FetchDataException(
            'Error occurred with status code ${response.statusCode}');
    }
  }

  @override
  Future getPostEmptyBodyApiResponse(String url,
      [Map<String, String>? headers]) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(
        url,
        options: Options(headers: headers),
      );
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  // void _handleDioException(DioException e) {
  //   // Handle DioException and extract more information
  //   String errorMessage = 'An unexpected error occurred';
  //   if (e.response != null) {
  //     errorMessage =
  //         'Error ${e.response?.statusCode}: ${e.response?.statusMessage}';
  //   } else if (e.type == DioExceptionType.connectionTimeout) {
  //     errorMessage = 'Connection timeout';
  //   } else if (e.type == DioExceptionType.sendTimeout) {
  //     errorMessage = 'Send timeout';
  //   } else if (e.type == DioExceptionType.receiveTimeout) {
  //     errorMessage = 'Receive timeout';
  //   } else if (e.type == DioExceptionType.cancel) {
  //     errorMessage = 'Request canceled';
  //   } else if (e.type == DioExceptionType.badResponse) {
  //     errorMessage = e.response?.statusMessage ?? "";
  //   } else if (e.type == DioExceptionType.unknown) {
  //     errorMessage = 'Unknown error occurred';
  //   }
  //   print(errorMessage);
  //   throw errorMessage;
  // }
}
