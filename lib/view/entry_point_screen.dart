import 'package:flutter/material.dart';
import 'package:muztunes_app/common/bottom_navigation_widget.dart';
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
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _expandAnimation;
  late final Animation<double> _slideAnimation;

  bool _isListVisible = false;

  @override
  void initState() {
    super.initState();
    _expandAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = CurvedAnimation(
      parent: _expandAnimation,
      curve: Curves.easeInOut,
    );
  }

  void _toggleListVisibility() {
    setState(() {
      _isListVisible = !_isListVisible;
      if (_isListVisible) {
        _expandAnimation.forward();
      } else {
        _expandAnimation.reverse();
      }
    });
  }

  @override
  void dispose() {
    _expandAnimation.dispose();
    super.dispose();
  }

  get pages {
    return [
      const SizedBox(),
      const HomeScreen(),
      const AboutScreen(),
      context.read<BottomNavigationProvider>().isLogin
          ? const LoginScreen()
          : const SignUpScreen(),
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
              _expandAnimation.reverse();
            });
          },
          child: Consumer<BottomNavigationProvider>(
            builder: (context, data, _) => pages[data.currentIndex.index],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Theme(
          data: ThemeData(
              bottomSheetTheme:
                  const BottomSheetThemeData(backgroundColor: Colors.black)
                      .copyWith(
                          backgroundColor: Colors.black,
                          elevation: 0.0,
                          shape: const BeveledRectangleBorder())),
          child: SizeTransition(
            sizeFactor: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.all(12.0),
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
        ),
        bottomNavigationBar: Consumer<BottomNavigationProvider>(
          builder: (BuildContext context, data, Widget? child) {
            return MyBottomNavigation(
                currentIndex: data.currentIndex,
                onTap: (value) {
                  if (value == Menus.add) {
                    _toggleListVisibility();
                    return;
                  }
                  data.setIndex(value);
                });
          },
        ));
  }
}

class MyBottomNavigation extends StatelessWidget {
  final Menus currentIndex;
  final ValueChanged<Menus> onTap;
  const MyBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      margin: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 17,
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Row(
                children: [
                  Expanded(
                    child: BottomNavigationItem(
                        onPressed: () => onTap(Menus.home),
                        icon: Icons.home,
                        current: currentIndex,
                        name: Menus.home),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                        onPressed: () => onTap(Menus.about),
                        icon: Icons.info_outline,
                        current: currentIndex,
                        name: Menus.about),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                        onPressed: () => onTap(Menus.auth),
                        icon: Icons.person,
                        current: currentIndex,
                        name: Menus.auth),
                  ),
                  const Spacer(),
                  Expanded(
                    child: BottomNavigationItem(
                        onPressed: () => onTap(Menus.cart),
                        icon: Icons.shopping_cart_sharp,
                        current: currentIndex,
                        name: Menus.cart),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                        onPressed: () => onTap(Menus.contact),
                        icon: Icons.perm_contact_cal_rounded,
                        current: currentIndex,
                        name: Menus.contact),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                        onPressed: () => onTap(Menus.concert),
                        icon: Icons.festival_rounded,
                        current: currentIndex,
                        name: Menus.concert),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => onTap(Menus.add),
              child: Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
