import 'package:flutter/material.dart';
import 'package:muztunes_app/extension/media_query_extension.dart';
import 'package:muztunes_app/view/shop/shop_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with TickerProviderStateMixin {
  bool isSelected = false;

  // Animation controllers
  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void setIsSelected() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: context.screenWidth * 0.2,
                    height: context.screenWidth * 0.2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Muztunes",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShopScreen()),
                );
              },
              title: Text(
                "SHOP",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            ListTile(
              onTap: setIsSelected,
              trailing: Icon(
                isSelected ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
              title: Text(
                "MUZTUNES PLATFORMS",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizeTransition(
              sizeFactor: _expandAnimation,
              child: Column(
                children: muztunesPlatform
                    .map((data) => InkWell(
                          onTap: () {},
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
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> muztunesPlatform = [
    {"title": "MUZCHAT"},
    {"title": "MUZCOM"},
    {"title": "MUZNEWS"},
    {"title": "MUZRADIO"},
    {"title": "MUZTUBE"},
    {"title": "CORPORATE SPONSORSHIP"},
  ];
}
