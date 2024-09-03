import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/model/user_model.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/repository/auth/auth_http_repository.dart';
import 'package:muztune/repository/auth/auth_repository.dart';
import 'package:muztune/view/auth/email_verification.dart';
import 'package:muztune/view/splash/splash_screen.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository authRepository = AuthHttpRepository();

  // Todo Login Method
  bool isLoginLoading = false;
  setLoginLoading(bool loading) {
    isLoginLoading = loading;
    notifyListeners();
  }

  Future<dynamic> loginUser(dynamic body, BuildContext context) async {
    setLoginLoading(true);
    await authRepository.loginUser(body).then((value) async {
      final UserModel userModel = UserModel.fromJson(value);
      await SessionController().saveUserPrefrence(userModel);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false);
        context.read<BottomNavigationProvider>().setIndex(Menus.home);
        // context.flushBarSuccessMessage(message: "User Login Successfully");
      }
      setLoginLoading(false);
    }).onError((error, _) {
      setLoginLoading(false);
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
    });
  }

  // Todo Register Method
  bool isRegisterLoading = false;
  setRegisterLoading(bool loading) {
    isRegisterLoading = loading;
    notifyListeners();
  }

  Future<dynamic> registerUser(dynamic body, BuildContext context) async {
    setRegisterLoading(true);
    await authRepository.registerUser(body).then((value) {
      setRegisterLoading(false);
      if (context.mounted) {
        context.flushBarSuccessMessage(message: "User Created Successfully");
        context.read<BottomNavigationProvider>().setIsLogin = true;
      }
    }).onError((error, _) {
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
      setRegisterLoading(false);
    });
  }

  // Todo Forgot Password Method
  bool isForgotPasswordLoading = false;
  setForgotPasswordLoading(bool loading) {
    isForgotPasswordLoading = loading;
    notifyListeners();
  }

  Future<dynamic> forgotPassword(dynamic body, BuildContext context) async {
    setForgotPasswordLoading(true);
    await authRepository.forgetPassword(body).then((value) {
      print(value["code"]);
      SessionController().otpCode = int.parse(value["code"]);
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const EmailVerificationScreen()));
        context.flushBarSuccessMessage(
            message: "Otp has been send to your email");
      }
      setForgotPasswordLoading(false);
    }).onError((error, _) {
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
      setForgotPasswordLoading(false);
    });
  }

  // Todo Reset Password Method
  bool isResetPasswordLoading = false;
  setResetPasswordLoading(bool loading) {
    isResetPasswordLoading = loading;
    notifyListeners();
  }

  Future<dynamic> resetPassword(dynamic body, BuildContext context) async {
    setResetPasswordLoading(true);
    await authRepository.resetPassword(body).then((value) {
      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const SplashScreen()));
        context.read<BottomNavigationProvider>().setIndex(Menus.home);
      }
      setResetPasswordLoading(false);
    }).onError((error, _) {
      setResetPasswordLoading(false);
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
    });
  }
}
