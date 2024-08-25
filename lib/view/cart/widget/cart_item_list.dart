import 'package:flutter/material.dart';
import 'package:muztunes_app/view/cart/widget/cart_item.dart';
import 'package:muztunes_app/view/cart/widget/product_cart_and_remove.dart';
import 'package:muztunes_app/view/cart/widget/t_product_price_text.dart';

class CartListItem extends StatelessWidget {
  final bool isShowAddOrRemove;
  const CartListItem({super.key, this.isShowAddOrRemove = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 24,
      ),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const CartItem(),
            if (isShowAddOrRemove)
              const SizedBox(
                height: 24,
              ),
            if (isShowAddOrRemove)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 70,
                      ),
                      // ! Add Remove Buttons
                      ProductCartAddAndRemoveButton(
                        quantity: 5,
                        add: () {},
                        remove: () {},
                      ),
                    ],
                  ),
                  // ! Product Total Price
                  const TProductPriceText(price: "100"),
                ],
              ),
          ],
        );
      },
    );
  }
}
