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
  Future getGetApiResponse(String url,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (_) {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic body,
      [Map<String, dynamic>? headers]) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
      );
      return _handleResponse(response);
    } on DioException catch (_) {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getPostFormApiResponse({
    required String url,
    Map<String, dynamic>? fields,
    required File file,
    bool isSingleFile = true,
    List<File>? files,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var formData = FormData();

      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      String contentType =
          lookupMimeType(file.path) ?? 'image/jpeg'; // Adjust as needed

      formData.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(file.path,
            contentType: MediaType.parse(contentType)),
      ));

      final response = await _dio.put(
        url,
        data: formData,
      );

      return _handleResponse(response);
    } on DioException catch (_) {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deletePostApiResponse(String url, dynamic body,
      [Map<String, dynamic>? headers]) async {
    try {
      final response = await _dio.delete(
        url,
        data: body,
      );
      return _handleResponse(response);
    } on DioException catch (_) {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      rethrow;
    }
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
        throw FetchDataException(response.statusMessage ?? 'An error occurred');
      default:
        throw FetchDataException(
            'Error occurred with status code ${response.statusCode}');
    }
  }

  @override
  Future putPostApiResponse(String url, body,
      [Map<String, String>? headers]) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
      );
      return _handleResponse(response);
    } on DioException catch (_) {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }
}
