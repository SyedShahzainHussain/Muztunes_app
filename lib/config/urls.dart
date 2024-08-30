import 'package:muztunes/environment/environment.dart';

class Urls {
  static get https => 'https://';
  static get http => 'http://';
  static final bool isHttp = Environment().baseConfig!.useHttps;
  static var baseUrl = isHttp
      ? '$https${Environment().baseConfig!.apiHost}'
      : '$http${Environment().baseConfig!.apiHost}';

  // Todo Auth Urls

  static String loginUrl = "$baseUrl/login";
  static String registerUrl = "$baseUrl/register";
  static String forgotPasswordUrl = "$baseUrl/forgot-password";
  static String resetPasswordUrl = "$baseUrl/reset-password";

  // Todo Products Urls
  static String allProductsUrl = "$baseUrl/product";
  // Todo Cart Urls
  static String cartPostUrl = "$baseUrl/cart";
  // Todo Category Urls
  static String categoryUrl = "$baseUrl/category";
}
