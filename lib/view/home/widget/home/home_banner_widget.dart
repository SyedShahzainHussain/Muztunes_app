import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/view/shop/shop_screen.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * .3,
            autoPlay: true,
            viewportFraction: 1,
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Image.network(
              "https://shop.muztunes.co/wp-content/uploads/2019/12/home-new-bg-free-img.jpg",
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .3,
              fit: BoxFit.cover,
            );
          }).toList(),
        ),
        // The image with a color overlay

        // The gradient overlay
        Opacity(
          opacity: 0.8, // Adjust the opacity as needed
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.70, 1.0],
                colors: [
                  Color.fromARGB(255, 255, 46,
                      31), // Starting color (with opacity applied by Opacity widget)
                  Color(0xff000000), // Ending color (adjust opacity if needed)
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight * 0.05,
              ),
              Text(
                "Official Merchandise From The Artists",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: context.screenHeight * 0.01,
              ),
              Text(
                "25% Off On All Products",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: context.screenHeight * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ShopScreen()));
                  },
                  borderColor: Colors.white,
                  color: Colors.white,
                  titleColor: Colors.black,
                  title: "SHOP NOW",
                ),
              ),
              SizedBox(
                height: context.screenHeight * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  onTap: () {
                    context
                        .read<BottomNavigationProvider>()
                        .setIndex(Menus.about);
                  },
                  borderColor: Colors.white,
                  title: "ABOUT US",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
