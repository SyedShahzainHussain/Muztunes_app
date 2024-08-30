import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muztunes/extension/flushbar_extension.dart';
import 'package:muztunes/model/cart_model.dart';
import 'package:muztunes/repository/cart/cart_http_repository.dart';
import 'package:muztunes/repository/cart/cart_repository.dart';
import 'package:muztunes/utils/utils.dart';
import 'package:muztunes/viewModel/storage/local_storage.dart';

class CartViewModel with ChangeNotifier {
  List<CartItemModel> cartList = [];

  int noOfCartItem = 0;
  double calculatedTotalPrice = 0.0;
  increaseCount() {
    int newCount = noOfCartItem + 1;
    noOfCartItem = newCount;
    notifyListeners();
  }

  decreaseCount() {
    if (noOfCartItem > 0) {
      int newCount = noOfCartItem - 1;
      noOfCartItem = newCount;
      notifyListeners();
    }
  }

  void addToCart(CartItemModel cartItemModel, BuildContext context) {
    int index = cartList.indexWhere(
        (cartItem) => cartItem.productId == cartItemModel.productId);
    if (index >= 0) {
      if (cartList[index].quantity == cartItemModel.quantity) {
        Utils.showToaster(
            context: context,
            message:
                "This Product Quantity is already in the cart. \nPlease increase quantity");
        return;
      } else {
        cartList[index].quantity += 1;
        Utils.showToaster(
            context: context, message: "Product quantity increased!");
      }
    } else {
      cartList.add(cartItemModel);
      Utils.showToaster(context: context, message: "Product Added!");
    }
    saveCartItem(cartList);
    updateCartTotal(cartList);
    noOfCartItem = 0;
    notifyListeners();
  }

  void addOneToCart(CartItemModel cartItemModel, BuildContext context) {
    int index = cartList.indexWhere(
        (cartItem) => cartItem.productId == cartItemModel.productId);

    if (index >= 0) {
      // Product is already in the cart, increment quantity by 1
      cartList[index].quantity += 1;
      // Utils.showToaster(
      //     context: context, message: "Product quantity increased!");
    } else {
      // Product is not in the cart, add it with initial quantity of 1
      cartItemModel.quantity = 1; // Ensure initial quantity is set to 1
      cartList.add(cartItemModel);
      // Utils.showToaster(context: context, message: "Product Added!");
    }
    updateCartTotal(cartList);
    saveCartItem(cartList);
    notifyListeners();
  }

  void removeFromCart(String productId, BuildContext context) {
    int index = cartList.indexWhere((item) => item.productId == productId);

    if (index >= 0) {
      if (cartList[index].quantity > 1) {
        // Decrease the quantity of the item
        cartList[index].quantity -= 1;
        // Utils.showToaster(
        //     context: context, message: "Product quantity decreased!");
      } else {
        // Remove the item from the cart if quantity is 1
        cartList.removeAt(index);
        // Utils.showToaster(
        //     context: context, message: "Product removed from cart!");
      }
    } else {
      context.flushBarErrorMessage(message: "Product not found in cart!");
    }
    updateCartTotal(cartList);
    saveCartItem(cartList);
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

  Future<void> saveCartItem(List<CartItemModel> cartItem) async {
    final cartItemJson =
        jsonEncode(cartItem.map((data) => data.toMap()).toList());
    await LocalStorage().setValue("cartItems", cartItemJson);
  }

  Future<void> loadCartItem() async {
    final String? cartItemJson = await LocalStorage().realValue("cartItems");
    if (cartItemJson != null) {
      try {
        final List<dynamic> cartItem = jsonDecode(cartItemJson);
        cartList.clear();
        cartList.addAll(cartItem.map((e) => CartItemModel.fromMap(e)).toList());
        updateCartTotal(cartList);
      } catch (e) {
        print("Failed to parse cart items: $e");
      }
    } else {
      print("No cart items found");
    }
  }

  // ! getPrdouctQuantityCart
  int getProductQuantityInCart(String productId) {
    return cartList
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
  }

// Method to get the total quantity of all items in the cart
  int getTotalQuantity() {
    return cartList.length;
  }

  void updateAlreadyAddedProductCount(String productID) {
    final quantity = getProductQuantityInCart(productID);

    // Update `noOfCartItem` based on the quantity
    noOfCartItem = quantity;

    // Notify listeners after updating the value
    notifyListeners();
  }

  bool cartLoading = false;
  setCartLoading(bool cartLoading) {
    this.cartLoading = cartLoading;
    notifyListeners();
  }

  final CartRepository cartRepository = CartHttpRepository();

  placeOrder(BuildContext context) async {
    setCartLoading(true);
    final orderData = {
      "cart": cartList.map((item) {
        return {
          "product": item.productId,
          "count": item.quantity,
        };
      }).toList(),
    };

    await cartRepository.addToCart(jsonEncode(orderData)).then((data) {
      clearCart();
      setCartLoading(false);
      if (context.mounted) {
        context.flushBarSuccessMessage(message: "Your order has been placed");
      }
    }).onError((error, _) {
      print(error);
      setCartLoading(false);
    });
  }

  void clearCart() {
    cartList.clear();
    noOfCartItem = 0;
    calculatedTotalPrice = 0.0;
    saveCartItem(cartList);
    notifyListeners();
  }
}
