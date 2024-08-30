import 'package:flutter/material.dart';
import 'package:muztunes/common/custom_app_bar.dart';
import 'package:muztunes/common/rating.dart';
import 'package:muztunes/view/home/widget/rating/t_overall_product_rating.dart';
import 'package:muztunes/view/home/widget/rating/t_user_rating.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Reviews & Rating"),
        showBackArrow: true,
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
