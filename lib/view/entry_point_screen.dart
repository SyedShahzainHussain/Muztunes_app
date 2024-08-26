import 'package:flutter/material.dart';
import 'package:muztunes_app/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class EntryPointScreen extends StatelessWidget {
  const EntryPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer<BottomNavigationProvider>(
          builder: (context, data, _) => data.pages[data.currentIndex]),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, data, _) => Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.black,
              ),
              child: BottomNavigationBar(
                unselectedItemColor: Colors.white,
                selectedItemColor: const Color(0xffEF4D48),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                currentIndex: data.currentIndex,
                onTap: (index) => data.setIndex(index),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline), label: "About"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "My Account"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag), label: "Cart"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.perm_contact_cal_rounded),
                      label: "Contact"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.festival_rounded), label: "Concert"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
