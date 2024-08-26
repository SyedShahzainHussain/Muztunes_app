import 'package:flutter/material.dart';

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

 
}
