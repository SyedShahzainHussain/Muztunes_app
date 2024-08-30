abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, [Map<String, dynamic>? queryParameters]);
  Future<dynamic> getPostApiResponse(String url, dynamic body,[Map<String,String>? headers]);
}