import 'dart:io';

import 'package:muztune/model/user_model.dart';

abstract class ProfileRepository {
  Future<dynamic> postFormData({
    required String url,
    Map<String, dynamic>? fields,
    File? file,
    bool isSingleFile,
    List<File>? files,
    Map<String, String>? headers,
  });

  Future<User> getProfileDetails(String userId);
}
