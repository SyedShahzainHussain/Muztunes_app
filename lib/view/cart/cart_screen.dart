import 'package:flutter/material.dart';
import 'package:muztune/common/bottom_navigation_widget.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/view/cart/widget/cart_item_list.dart';
import 'package:muztune/viewModel/cart/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, data, _) {
      return Theme(
        data: ThemeData(
            dividerTheme: const DividerThemeData().copyWith(
                color:
                    data.cartList.isEmpty ? Colors.transparent : Colors.black)),
        child: Scaffold(
         
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
        ),
      );
    });
  }

  authenictate(BuildContext context) {
    context.flushBarErrorMessage(message: "You are not authenticated");
    context.read<BottomNavigationProvider>().setIndex(Menus.auth);
  }
}
