import 'package:flutter/material.dart';
import 'package:muztune/common/custom_app_bar.dart';
import 'package:muztune/common/rating.dart';
import 'package:muztune/view/home/widget/rating/t_overall_product_rating.dart';
import 'package:muztune/view/home/widget/rating/t_user_rating.dart';
import 'package:muztune/view/rating/add_rating_screen.dart';

class ProductRating extends StatelessWidget {
  final String type;
  final String productId;
  const ProductRating({super.key, required this.type, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Reviews & Rating"),
        showBackArrow: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddRatingScreen(
                              type: type,
                              productId: productId,
                            )));
              },
              icon: const Icon(Icons.create)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews are verified and are from people who use the same type of device that uoy use.",
              ),
              const SizedBox(
                height: 24,
              ),
              // ! Overall Product Ratings
              const OverAllProductRating(),
              const RatingIndicator(
                rating: 3.5,
              ),
              Text(
                "13,411",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 16,
              ),
              const UserRating(),
              const UserRating(),
            ],
          ),
        ),
      ),
    );
  }
}
