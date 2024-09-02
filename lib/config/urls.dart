import 'package:muztune/environment/environment.dart';

class Urls {
  static get https => 'https://';
  static get http => 'http://';
  static final bool isHttp = Environment().baseConfig!.useHttps;
  static var baseUrl = isHttp
      ? '$https${Environment().baseConfig!.apiHost}'
      : '$http${Environment().baseConfig!.apiHost}';

  // Todo Auth Urls

  static String loginUrl = "login";
  static String registerUrl = "register";
  static String forgotPasswordUrl = "forgot-password";
  static String resetPasswordUrl = "reset-password";

  // Todo Products Urls
  static String allProductsUrl = "product";
  // Todo Cart Urls
  static String cartPostUrl = "cart";
  static String deleteCartUrls = "cart";

  // Todo Category Urls
  static String categoryUrl = "category";
  // Todo Artcile Urls
  static String articleUrl = "article";
  static String updatedProfileUrl = "update-user";
  // Todo Orders Urls
  static String orderUrls = "getorders";
  // Todo Profile Urls
  static String profileDetailsUrls = "user-details";
  // Todo  Urls
  static String postRatingUrl = "rating";
}
