import 'package:flutter/material.dart';
import 'package:muztunes_apps/viewModel/services/session_controller/session_controller.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) {
    SessionController().getUserPrefrences();
  }
}
