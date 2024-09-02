import 'package:flutter/material.dart';
import 'package:muztune/common/heading.dart';
import 'package:muztune/view/drawer/drawer_screen.dart';
import 'package:muztune/view/home/all_merch_artists_screen.dart';
import 'package:muztune/view/home/all_product_screen.dart';
import 'package:muztune/view/home/widget/home/home_banner_widget.dart';
import 'package:muztune/view/home/widget/home/home_grid_product_widget.dart';
import 'package:muztune/view/home/widget/products/articles_widget.dart';
import 'package:muztune/view/home/widget/products/featured_product_widget.dart';
import 'package:muztune/viewModel/cart/cart_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartViewModel>().loadCartItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerScreen(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 87 + 10),
          child: Column(
            children: [
              // Todo Banner
              const HomeBanner(),
              // Todo  Grid Product
              const HomeGridProduct(),
              const SizedBox(
                height: 10,
              ),
              // Todo Featured Prodcuts
              Heading(
                title: "Featured Prodcuts",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AllProductScreen()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const FeaturedProductWidget(),
              const SizedBox(
                height: 10,
              ),
              // Todo Merch Prodcuts
              Heading(
                title: "Merch Directly from Artists",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AllMerchArtistsScreen()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const ArticleListWidget(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
