import 'package:flutter/material.dart';
import 'package:muztunes_apps/common/t_rounded_image.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/view/cart/widget/t_product_title.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String category;
  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ! Image
        TRoundedImage(
          imageUrl: image,
          width: 60,
          isNetworkImage: true,
          height: 60,
          padding: const EdgeInsets.all(4),
          backgroundColor: AppColors.redColor,
        ),
        const SizedBox(
          width: 24,
        ),
        // ! Title , Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TProductTitle(
                  title: title,
                  maxLines: 1,
                ),
              ),
              Flexible(
                child: TProductTitle(
                  title: description,
                  maxLines: 1,
                ),
              ),
              Flexible(
                child: TProductTitle(
                  title: category,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
