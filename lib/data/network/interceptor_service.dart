// Api class

// class Api {
//   final Dio dio;

//   Api() : dio = Dio() {
//     dio.interceptors.add(AuthInterceptor()); // Add AuthInterceptor
//   }

import 'package:dio/dio.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/config/urls.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/utils/global_context.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final modifiedOptions = options.copyWith(
      validateStatus: (statusCode) =>
          statusCode != null && statusCode >= 200 && statusCode < 500,
      // baseUrl: 'http://localhost:8000/v1',
      baseUrl: "${Urls.baseUrl}/",
      headers: <String, String>{
        "Authorization":
            "${SessionController().userModel.token}", // Replace with your authorization method
      },
    );
    return handler.next(modifiedOptions);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      ContextUtility.context.flushBarErrorMessage(message: "Token Expired");
      if (ContextUtility.context
              .read<BottomNavigationProvider>()
              .currentIndex ==
          Menus.auth) {
        ContextUtility.context
            .read<BottomNavigationProvider>()
            .setIndex(Menus.home);
      } else {
        ContextUtility.context
            .read<BottomNavigationProvider>()
            .setIndex(Menus.auth);
      }

      SessionController().logout();
      SessionController().getUserPrefrences();
    }
    print('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print('ERROR[${err.response}] => PATH: ${err.requestOptions.path}');
    return handler.next(err);
  }
}
