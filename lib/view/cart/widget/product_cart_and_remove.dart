import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztune/common/t_circular_icon.dart';
import 'package:muztune/config/colors.dart';

class ProductCartAddAndRemoveButton extends StatelessWidget {
  final int quantity;
  final VoidCallback? add, remove;
  const ProductCartAddAndRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcons(
          onPressed: remove,
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          iconSize: 16,
          color: Colors.black,
          backgroundColor: AppColors.redColor,
        ),
        const SizedBox(
          width: 24,
        ),
        Text(quantity.toString()),
        const SizedBox(
          width: 24,
        ),
        TCircularIcons(
          onPressed: add,
          icon: Iconsax.add,
          width: 32,
          height: 32,
          iconSize: 16,
          color: Colors.white,
          backgroundColor: AppColors.redColor,
        )
      ],
    );
  }
}
