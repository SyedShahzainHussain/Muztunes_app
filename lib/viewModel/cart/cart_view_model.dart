import 'package:flutter/material.dart';
import 'package:muztunes_apps/extension/flushbar_extension.dart';
import 'package:muztunes_apps/model/cart_model.dart';

class CartViewModel with ChangeNotifier {
  List<CartItemModel> cartList = [];

  int noOfCartItem = 0;
  double calculatedTotalPrice = 0.0;
  increaseCount() {
    noOfCartItem++;
    notifyListeners();
  }

  decreaseCount() {
    if (noOfCartItem > 0) {
      noOfCartItem--;
      notifyListeners();
    }
  }

  void addToCart(CartItemModel cartItemModel, BuildContext context) {
    int index = cartList.indexWhere(
        (cartItem) => cartItem.productId == cartItemModel.productId);
    if (index >= 0) {
      if (cartList[index].quantity == cartItemModel.quantity) {
        context.flushBarSuccessMessage(
            message:
                "This Product Quantity is already in the cart.\nPlease increase quantity");
      } else {
        cartList[index].quantity += 1;
      }
    } else {
      cartList.add(cartItemModel);
      context.flushBarSuccessMessage(message: "Product Added!");
    }

    notifyListeners();
  }

  void addOneToCart(CartItemModel cartItemModel, BuildContext context) {
    int index = cartList.indexWhere(
        (cartItem) => cartItem.productId == cartItemModel.productId);

    if (index >= 0) {
      // Product is already in the cart, increment quantity by 1
      cartList[index].quantity += 1;
      context.flushBarSuccessMessage(message: "Product quantity increased!");
    } else {
      // Product is not in the cart, add it with initial quantity of 1
      cartItemModel.quantity = 1; // Ensure initial quantity is set to 1
      cartList.add(cartItemModel);
      context.flushBarSuccessMessage(message: "Product Added!");
    }
    updateCartTotal(cartList);
    notifyListeners();
  }

  void removeFromCart(String productId, BuildContext context) {
    int index = cartList.indexWhere((item) => item.productId == productId);

    if (index >= 0) {
      if (cartList[index].quantity > 1) {
        // Decrease the quantity of the item
        cartList[index].quantity -= 1;
        context.flushBarSuccessMessage(message: "Product quantity decreased!");
      } else {
        // Remove the item from the cart if quantity is 1
        cartList.removeAt(index);
        context.flushBarSuccessMessage(message: "Product removed from cart!");
      }
    } else {
      context.flushBarErrorMessage(message: "Product not found in cart!");
    }
    updateCartTotal(cartList);
    notifyListeners();
  }

  updateCartTotal(
    List<CartItemModel> cartItem,
  ) {
    double calculatedTotalPrice = 0.0;
    int calculatedNoItem = 0;
    for (var item in cartItem) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoItem += item.quantity;
    }
    noOfCartItem = calculatedNoItem;
    this.calculatedTotalPrice = calculatedTotalPrice;
    notifyListeners();
  }
}
