import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(
    String url, [
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    dynamic body,
  ]);

  Future<dynamic> getPostApiResponse(String url, dynamic body,
      [Map<String, String>? headers]);


  Future<dynamic> getPostEmptyBodyApiResponse(String url,
      [Map<String, String>? headers]);
  Future<dynamic> deletePostApiResponse(String url,
      [ dynamic body,Map<String, String>? headers]);

  Future<dynamic> putPostApiResponse(String url, dynamic body,
      [Map<String, String>? headers]);

  Future<dynamic> getPutFormApiResponse({
    required String url,
    Map<String, dynamic>? fields,
    required File file,
    bool isSingleFile = true,
    List<File>? files,
    Map<String, String>? headers,
  });

  Future<dynamic> getPostFormApiResponse({
    required String url,
    Map<String, dynamic>? fields,
    List<File>? files, // List of multiple files
    Map<String, dynamic>? headers,
  });

  Future<dynamic> getPostSingleImageFormApiResponse( {
    required String url,
    Map<String, dynamic>? fields,
    File? files, // List of multiple files
    Map<String, dynamic>? headers,
  });





}
