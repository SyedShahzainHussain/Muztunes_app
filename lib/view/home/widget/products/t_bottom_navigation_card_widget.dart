import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztunes_app/common/button.dart';
import 'package:muztunes_app/common/t_circular_icon.dart';
import 'package:muztunes_app/config/colors.dart';

class TBottomNavigationCardWidget extends StatelessWidget {
  const TBottomNavigationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24 / 2),
      decoration: const BoxDecoration(
        color: Color(0xFF4F4F4F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcons(
                icon: Iconsax.minus,
                backgroundColor: AppColors.redColor,
                width: 40,
                height: 40,
                color: Colors.white,
                onPressed: () {},
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                "0",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                width: 12,
              ),
              TCircularIcons(
                  icon: Iconsax.add,
                  backgroundColor: AppColors.redColor,
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  onPressed: () {}),
            ],
          ),
          const Button(
            showRadius: true,
            title: "Add To Cart",
            color: AppColors.redColor,
            borderColor: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}
