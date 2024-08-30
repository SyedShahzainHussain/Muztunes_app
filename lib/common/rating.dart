import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztunes/config/colors.dart';

class RatingIndicator extends StatelessWidget {
  const RatingIndicator({
    super.key,
    required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemSize: 20,
      rating: rating,
      itemBuilder: (context, index) {
        return const Icon(
          Iconsax.star1,
          color: AppColors.redColor,
        );
      },
    );
  }
}
