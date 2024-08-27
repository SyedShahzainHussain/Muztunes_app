import 'package:flutter/material.dart';
import 'package:muztunes_app/config/colors.dart';

class BottomNavigationItem extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Menus current;
  final Menus name;
  const BottomNavigationItem(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.current,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: onPressed,
        tooltip: name.name,
        icon: Icon(
          icon,
          color: current == name ? AppColors.redColor : Colors.white,
        ),
      ),
    );
  }
}

enum Menus {
  add,
  home,
  about,
  auth,
  cart,
  contact,
  concert,
}
