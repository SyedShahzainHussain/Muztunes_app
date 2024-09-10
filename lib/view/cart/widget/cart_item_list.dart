import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/view/cart/widget/cart_item.dart';
import 'package:muztune/view/home/product_detail_screen.dart';
import 'package:muztune/viewModel/cart/cart_view_model.dart';
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
                return Dismissible(
                  key: ValueKey(cart.productId),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (DismissDirection direction) async {
                    if (direction == DismissDirection.endToStart) {
                      // Show a confirmation dialog
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Are you sure?'),
                            content: const Text(
                              'This action will permanently delete this data',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.black),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.red),
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                      if (result == true) {
                        if (context.mounted) {
                          context
                              .read<CartViewModel>()
                              .removeCart(cart.productId);
                        }
                      }
                      // Return the result of the dialog to confirm or deny the dismissal
                      return result ?? false;
                    }
                    // In case the direction is not endToStart, don't dismiss
                    return false;
                  },
                  background: Container(
                    color: Colors.white,
                    child: const Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                    title: cart.title,
                                    description: cart.description,
                                    category: cart.category,
                                    tags: cart.tags!,
                                    price: cart.price.toString(),
                                    productId: cart.productId,
                                    type: cart.type,
                                    image: cart.image,
                                    images: cart.images??[],
                                    isProduct:
                                        cart.type == "product" ? true : false,
                                           link: cart.link,
                                           information: cart.information??"",
                                           colors: cart.colors??[],
                                  )));
                    },
                    child: CartItem(
                      image: cart.image,
                      title: cart.title,
                      description: cart.description,
                      category: cart.category,
                      price: cart.price,
                    ),
                  ),
                );
              },
            );
    });
  }
}
