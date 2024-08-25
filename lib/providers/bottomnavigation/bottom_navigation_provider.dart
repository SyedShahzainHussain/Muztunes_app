import 'package:flutter/material.dart';
import 'package:muztunes_app/view/about/about_screen.dart';
import 'package:muztunes_app/view/contact/contact_screen.dart';
import 'package:muztunes_app/view/auth/login_screen.dart';
import 'package:muztunes_app/view/auth/sign_up_screen.dart';
import 'package:muztunes_app/view/cart/cart_screen.dart';
import 'package:muztunes_app/view/home/home_screen.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  set setIsLogin(bool login) {
    _isLogin = login;
    notifyListeners();
  }

  setIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  List<Widget> get pages {
    return [
      const HomeScreen(),
      const AboutScreen(),
      _isLogin ? const LoginScreen() : const SignUpScreen(),
      const CartScreen(),
      const ContactScreen(),
    ];
  }
}
