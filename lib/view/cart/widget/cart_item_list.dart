import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/model/cart_model.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/view/cart/widget/cart_item.dart';
import 'package:muztune/view/cart/widget/product_cart_and_remove.dart';
import 'package:muztune/view/cart/widget/t_product_price_text.dart';
import 'package:muztune/viewModel/cart/cart_view_model.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final bool isShowAddOrRemove;
  const CartListItem({super.key, this.isShowAddOrRemove = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, data, _) {
      return data.cartList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/cart.png",
                    width: context.screenWidth * 0.5,
                    height: context.screenWidth * 0.5,
                  ),
                  Text(
                    "Good Food is Always Cookings",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Your Cart is Empty.",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: context.screenWidth * .5,
                    child: Button(
                      title: "Shop Now",
                      color: AppColors.redColor,
                      onTap: () {
                        context
                            .read<BottomNavigationProvider>()
                            .setIndex(Menus.home);
                      },
                    ),
                  )
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const SizedBox(
                height: 24,
              ),
              shrinkWrap: true,
              itemCount: data.cartList.length,
              itemBuilder: (context, index) {
                final cart = data.cartList[index];
                return Column(
                  children: [
                    CartItem(
                      image: cart.image,
                      title: cart.title,
                      description: cart.description,
                      category: cart.category,
                    ),
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
                              Consumer<CartViewModel>(
                                  builder: (context, data, _) {
                                return ProductCartAddAndRemoveButton(
                                  quantity: data.cartList[index].quantity,
                                  add: () {
                                    final cartItemModel = CartItemModel(
                                      productId: cart.productId,
                                      description: cart.description,
                                      quantity: context
                                          .read<CartViewModel>()
                                          .noOfCartItem,
                                      image: context
                                          .read<ProductViewModel>()
                                          .selectedImage,
                                      tags: cart.tags,
                                      title: cart.title,
                                      category: cart.category,
                                      price: cart.price,
                                    );
                                    context
                                        .read<CartViewModel>()
                                        .addOneToCart(cartItemModel, context);
                                  },
                                  remove: () {
                                    context
                                        .read<CartViewModel>()
                                        .removeFromCart(
                                            cart.productId, context);
                                  },
                                );
                              }),
                            ],
                          ),
                          // ! Product Total Price
                          TProductPriceText(price: cart.price.toString()),
                        ],
                      ),
                  ],
                );
              },
            );
    });
  }
}
