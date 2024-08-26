import 'package:flutter/material.dart';
import 'package:muztunes_app/view/home/widget/products/featured_product_widget.dart';

import '../../common/filter_price_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Text("Shop",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white)),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: FilterPriceWidget(),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            FeaturedProductWidget(),
          ],
        ),
      ),
    );
  }
}