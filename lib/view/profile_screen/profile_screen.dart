import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/common/t_rounded_container.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/view/profile_screen/edit_profile_screen.dart';
import 'package:muztune/view/splash/splash_screen.dart';
import 'package:muztune/viewModel/profile/profile_view_model.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProfileViewModel>()
          .getProfileDetails(SessionController().userModel.user!.id!);
    });
  }

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
          actions: [
            // TextButton(
            //     onPressed: () async {
            //       await SessionController().logout().then((value) {
            //         if (context.mounted) {
            //           Navigator.pushAndRemoveUntil(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (_) => const SplashScreen()),
            //               (route) => false);
            //           context
            //               .read<BottomNavigationProvider>()
            //               .setIndex(Menus.home);
            //         }
            //       });
            //     },
            //     child: const Text("Asdsd")),
            Consumer<ProfileViewModel>(builder: (context, data, _) {
              switch (data.userProfile.status) {
                case Status.LOADING:
                  return const SizedBox();
                case Status.COMPLETED:
                  return TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditProfileScreen(
                                    image: data.userProfile.data!.image!,
                                    title: data.userProfile.data!.name!)));
                      },
                      child: const Text("Edit",
                          style: TextStyle(color: AppColors.redColor)));
                case Status.ERROR:
                  return const SizedBox();
              }
            })
          ],
        ),
        body: Consumer<ProfileViewModel>(builder: (context, data, _) {
          switch (data.userProfile.status) {
            case Status.LOADING:
              return const Center(
                child: TRoundedContainer(
                  padding: EdgeInsets.all(12),
                  width: 50,
                  height: 50,
                  backgroundColor: AppColors.redColor,
                  showBorder: true,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3.0,
                  ),
                ),
              );

            case Status.COMPLETED:
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Todo Profile Picture
                      Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.redColor,
                                  width: 2.0,
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FancyShimmerImage(
                                boxDecoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                imageUrl: data.userProfile.data!.image!,
                                width: double.infinity,
                                boxFit: BoxFit.cover,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(data.userProfile.data!.name!,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTileWidget(
                        icon: Icons.person,
                        title: data.userProfile.data!.name!,
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTileWidget(
                        icon: Icons.email,
                        title: data.userProfile.data!.email!,
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ListTileWidget(
                      //   icon: Icons.location_on,
                      //   title: "Karachi, Pakistan",
                      //   onTap: () {},
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
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
                ),
              );
            case Status.ERROR:
              return Center(
                child: Text(data.userProfile.message!),
              );
          }
        }));
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
