import 'package:flutter/material.dart';
import 'package:muztunes_app/common/t_rounded_image.dart';
import 'package:muztunes_app/config/colors.dart';
import 'package:muztunes_app/view/cart/widget/t_product_title.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // ! Image
        TRoundedImage(
          imageUrl:
              "https://shop.muztunes.co/wp-content/uploads/2023/01/Madonna-Black-300x300.jpg",
          width: 60,
          isNetworkImage: true,
          height: 60,
          padding: EdgeInsets.all(4),
          backgroundColor: AppColors.redColor,
        ),
        SizedBox(
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
                  title: "Shirts",
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
