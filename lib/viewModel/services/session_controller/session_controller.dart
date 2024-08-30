import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muztunes_apps/model/user_model.dart';
import 'package:muztunes_apps/viewModel/storage/local_storage.dart';

class SessionController {
  static final SessionController _sessionController =
      SessionController._interval();

  factory SessionController() {
    return _sessionController;
  }

  UserModel userModel = UserModel();
  bool? isLogin;
  LocalStorage localStorage = LocalStorage();
  int? otpCode;

  SessionController._interval() {
    isLogin = false;
  }

  Future<void> saveUserPrefrence(dynamic user) async {
    await localStorage.setValue("token", jsonEncode(user));
    await localStorage.setValue("isLogin", "true");
  }

  Future<void> getUserPrefrences() async {
    try {
      var userData = await localStorage.realValue("token");
      var isLogin = await localStorage.realValue("isLogin");
      if (userData != null) {
        SessionController().userModel =
            UserModel.fromJson(jsonDecode(userData));
      }
      SessionController().isLogin = isLogin == "true" ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    await localStorage.clearValue("token");
    await localStorage.clearValue("isLogin");
    userModel = UserModel();
  }
}
