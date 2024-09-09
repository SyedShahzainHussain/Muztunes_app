import 'package:flutter/material.dart';
import 'package:muztune/common/t_rounded_image.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/view/cart/widget/t_product_price_text.dart';
import 'package:muztune/view/cart/widget/t_product_title.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String category;
  final double price;
  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
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
        TProductPriceText(price: price.toString()),
      ],
    );
  }
}
