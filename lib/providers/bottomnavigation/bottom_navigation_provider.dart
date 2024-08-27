import 'package:flutter/material.dart';
import 'package:muztunes_app/common/bottom_navigation_widget.dart';

class BottomNavigationProvider with ChangeNotifier {
  Menus _currentIndex = Menus.home;
  Menus get currentIndex => _currentIndex;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  set setIsLogin(bool login) {
    _isLogin = login;
    notifyListeners();
  }

  setIndex(Menus currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

 
}
