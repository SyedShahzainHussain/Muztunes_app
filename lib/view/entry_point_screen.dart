import 'package:flutter/material.dart';
import 'package:muztunes_app/config/colors.dart';
import 'package:muztunes_app/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztunes_app/view/about/about_screen.dart';
import 'package:muztunes_app/view/auth/login_screen.dart';
import 'package:muztunes_app/view/auth/sign_up_screen.dart';
import 'package:muztunes_app/view/cart/cart_screen.dart';
import 'package:muztunes_app/view/concert/concert_screen.dart';
import 'package:muztunes_app/view/contact/contact_screen.dart';
import 'package:muztunes_app/view/drawer/drawer_screen.dart';
import 'package:muztunes_app/view/home/home_screen.dart';
import 'package:provider/provider.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  _EntryPointScreenState createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _slideAnimation;

  bool _isListVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<double>(begin: -200.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleListVisibility() {
    setState(() {
      _isListVisible = !_isListVisible;
      if (_isListVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> get pages {
    return [
      const HomeScreen(),
      const AboutScreen(),
      context.read<BottomNavigationProvider>().isLogin
          ? const LoginScreen()
          : const SignUpScreen(),
      Container(),
      const CartScreen(),
      const ContactScreen(),
      const ConcertScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isListVisible = false;
          });
        },
        child: Consumer<BottomNavigationProvider>(
          builder: (context, data, _) => pages[data.currentIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Animated sliding list
          if (_isListVisible)
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(_animationController),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(
                    bottom:
                        kBottomNavigationBarHeight), // Adjust this margin to fit above the FAB

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: muztunesPlatform
                      .map((data) => InkWell(
                            onTap: () {
                              setState(() {
                                _isListVisible = false;
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  data["title"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
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
                onTap: (index) {
                  if (index == 3) {
                    _toggleListVisibility(); // Toggle list visibility if the 4th item is tapped
                  } else {
                    data.setIndex(index); // Set the index for other taps
                    if (_isListVisible) {
                      _toggleListVisibility(); // Hide list if another item is tapped
                    }
                  }
                },
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline), label: "About"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "My Account"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopify_sharp,
                        color: _isListVisible == true
                            ? AppColors.redColor
                            : Colors.white,
                      ),
                      label: "Shoppiyfy"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_sharp), label: "Cart"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.perm_contact_cal_rounded),
                      label: "Contact"),
                  const BottomNavigationBarItem(
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
