import 'package:flutter/material.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/view/admin/admin_screen.dart';
import 'package:muztune/view/orders/order_screen.dart';
import 'package:muztune/view/shop/shop_screen.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';

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
        child: SingleChildScrollView(
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
              const SizedBox(
                height: 10,
              ),
              SessionController().userModel.user != null
                  ? ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OrderScreen()),
                        );
                      },
                      title: Text(
                        "Orders",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    )
                  : const SizedBox(),
              SessionController().userModel.user?.role == "admin"
                  ? ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AdminScreen()),
                        );
                      },
                      title: Text(
                        "Admin",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    )
                  : const SizedBox(),
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
                            onTap: () async {
                              await Utils().launchUrls(data["url"]);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
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
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> muztunesPlatform = [
  {
    "title": "MUZCHAT",
    "url": "https://chat.muztunes.co/#",
  },
  {
    "title": "MUZCOM",
    "url": "https://social.muztunes.co/",
  },
  {
    "title": "MUZNEWS",
    "url": "https://muztunes.co/news/",
  },
  {
    "title": "MUZRADIO",
    "url": "https://muztunes.co/muz-radio",
  },
  {
    "title": "MUZTUBE",
    "url": "https://muztunes.co/muz-radio",
  },
  {
    "title": "CORPORATE SPONSORSHIP",
    "url": "https://muztunes.co/coming-soon/",
  },
];
