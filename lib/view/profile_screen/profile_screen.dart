import 'package:flutter/material.dart';
import 'package:muztunes_apps/common/bottom_navigation_widget.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztunes_apps/view/splash/splash_screen.dart';
import 'package:muztunes_apps/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Profile",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Todo Profile Picture
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.redColor,
                            width: 2.0,
                          )),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg"),
                        radius: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: -5,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.redColor,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(SessionController().userModel.user?.name ?? "Guest",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
              const SizedBox(
                height: 10,
              ),
              ListTileWidget(
                icon: Icons.person,
                title: SessionController().userModel.user?.name ?? "Guest",
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              ListTileWidget(
                icon: Icons.email,
                title: SessionController().userModel.user?.email ??
                    "Guest@gmail.com",
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              ListTileWidget(
                icon: Icons.location_on,
                title: "Karachi, Pakistan",
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              ListTileWidget(
                icon: Icons.logout,
                title: "Logout",
                onTap: () async {
                  await SessionController().logout().then((value) {
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SplashScreen()),
                          (route) => false);
                      context
                          .read<BottomNavigationProvider>()
                          .setIndex(Menus.home);
                    }
                  });
                },
              ),
            ],
          ),
        ));
  }
}

class ListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const ListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(4),
          onTap: onTap,
          leading: Icon(icon, color: AppColors.redColor),
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
