import 'package:flutter/material.dart';
import 'package:muztunes/common/filter_price_widget.dart';

import 'widget/home/merch_product_widget.dart';

class AllMerchArtistsScreen extends StatelessWidget {
  const AllMerchArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Text("All Merch Artists",
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
            // MerchProductWidget(),
          ],
        ),
      ),
    );
  }
}
