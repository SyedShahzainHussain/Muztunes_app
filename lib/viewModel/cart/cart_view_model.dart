import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/model/cart_model.dart';
import 'package:muztune/repository/cart/cart_http_repository.dart';
import 'package:muztune/repository/cart/cart_repository.dart';
import 'package:muztune/viewModel/order/order_view_model.dart';
import 'package:muztune/viewModel/storage/local_storage.dart';
import 'package:provider/provider.dart';

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
   if(index>=0){
    cartList[index] = cartItemModel;
   }else{
    cartList.add(cartItemModel);
   }
  //  Utils.showToaster(message: "Added", context: context);
     saveCartItem(cartList);
   notifyListeners();
  }

  void removeCart(String productId){
  int index = cartList.indexWhere((item) => item.productId == productId);
    cartList.removeAt(index);
    saveCartItem(cartList);
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
      "cart": cartList
          .map((item) {
            // Check item type and construct the correct map
            if (item.type == 'product') {
              return {  
                "product": item.productId,
                "count": item.quantity,
              }; 
            } else if (item.type == 'article') {
              return {
                "article": item
                    .productId, // Assuming `productId` is used for article IDs
                "count": item.quantity,
              };
            }
            return null; // In case the type is neither 'product' nor 'article'
          })
          .where((item) => item != null)
          .toList() // Remove null values
    };

    // final placeOrderData = {
    //   "products": cartList.map((item) {
    //     return {
    //       "product": item.productId,
    //       "count": item.quantity,
    //       "price": item.price
    //     };
    //   }).toList() //
    // };

    await cartRepository.addToCart(jsonEncode(orderData)).then((data) async {
      if (context.mounted) {
        await context.read<OrderViewModel>().placeOrdersApi();
      }
      await deleteCart();
      clearCart();
      setCartLoading(false);
      if (context.mounted) {
        context.flushBarSuccessMessage(message: "Your order has been placed");
      }
    }).onError((error, _) {
      setCartLoading(false);
      if (context.mounted) {
        context.flushBarErrorMessage(message: error.toString());
      }
      print(error);
    });
  }

  void clearCart() {
    cartList.clear();
    noOfCartItem = 0;
    calculatedTotalPrice = 0.0;
    saveCartItem(cartList);
    notifyListeners();
  }

  Future<void> deleteCart() async {
    // Create a list of maps with each item to remove
    final itemsToRemove = {
      "itemsToRemove": cartList.map((e) {
        return {
          "id": e.productId,
          "type": e.type,
        };
      }).toList()
    };
    await cartRepository.deleteToCart(jsonEncode(itemsToRemove)).then((data) {
      print(data);
    }).onError((error, _) {
      print(error);
    });
  }
}
