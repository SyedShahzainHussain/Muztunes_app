import 'package:flutter/material.dart';
import 'package:muztunes/common/bottom_navigation_widget.dart';
import 'package:muztunes/common/button.dart';
import 'package:muztunes/config/colors.dart';
import 'package:muztunes/extension/flushbar_extension.dart';
import 'package:muztunes/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztunes/view/cart/widget/cart_item_list.dart';
import 'package:muztunes/viewModel/cart/cart_view_model.dart';
import 'package:muztunes/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Consumer<CartViewModel>(
                builder: (context, data, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount",
                        style: Theme.of(context).textTheme.labelLarge),
                    Text("\$${data.calculatedTotalPrice.toStringAsFixed(2)}",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<CartViewModel>(
                builder: (context, data, _) => Button(
                  loading: data.cartLoading,
                  onTap: data.cartList.isEmpty
                      ? null
                      : () {
                          SessionController().userModel.user == null
                              ? authenictate(context)
                              : context
                                  .read<CartViewModel>()
                                  .placeOrder(context);
                        },
                  title: "Place Order",
                  color:
                      data.cartList.isEmpty ? Colors.grey : AppColors.redColor,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
      ],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Cart",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: CartListItem(),
      ),
    );
  }

  authenictate(BuildContext context) {
    context.flushBarErrorMessage(message: "You are not authenticated");
    context.read<BottomNavigationProvider>().setIndex(Menus.auth);
  }
}
