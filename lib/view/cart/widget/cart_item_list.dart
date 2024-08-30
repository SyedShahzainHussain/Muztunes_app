import 'package:flutter/material.dart';
import 'package:muztunes_apps/model/cart_model.dart';
import 'package:muztunes_apps/view/cart/widget/cart_item.dart';
import 'package:muztunes_apps/view/cart/widget/product_cart_and_remove.dart';
import 'package:muztunes_apps/view/cart/widget/t_product_price_text.dart';
import 'package:muztunes_apps/viewModel/cart/cart_view_model.dart';
import 'package:muztunes_apps/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final bool isShowAddOrRemove;
  const CartListItem({super.key, this.isShowAddOrRemove = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, data, _) {
      return data.cartList.isEmpty
          ? const Center(child: Text("No Cart Found"))
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
                                print(data.calculatedTotalPrice);
                                return ProductCartAddAndRemoveButton(
                                  quantity: data.noOfCartItem,
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
