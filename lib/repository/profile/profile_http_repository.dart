import 'dart:io';

import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/user_model.dart';
import 'package:muztune/repository/profile/profile_repository.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';

class ProfileHttpRepository extends ProfileRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future<dynamic> postFormData({
    required String url,
    Map<String, dynamic>? fields,
    List<File>? files,
    Map<String, String>? headers,
    File? file,
    bool isSingleFile = true, // Default value provided here
  }) async {
    try {
      dynamic response = await baseApiServices.getPostFormApiResponse(
        url: url,
        fields: fields,
        file: file!,
        isSingleFile: isSingleFile, // Ensure default value or check null
        files: files,
        headers: headers,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getProfileDetails(String userId) async {
    try {
      final response = await baseApiServices
          .getGetApiResponse("${Urls.profileDetailsUrls}/$userId", {}, {
        "Authorization": SessionController().userModel.token!,
        "Content-Type": "multipart/form-data"
      });
      return User.fromJson(response["message"]);
    } catch (e) {
      rethrow;
    }
  }
}
