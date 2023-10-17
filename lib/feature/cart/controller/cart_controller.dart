import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/feature/checkout/pages/checkout_page.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/widgets/toast_v3_widget.dart';

class CartController extends ChangeNotifier {
  CartController(this.context);
  BuildContext context;
  FavoriteProvider? favorite;
  CartProvider? cart;
  List<CartModel> cartList = [];
  num totalPrice = 0;

  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context, listen: false);
    getCart();
  }

  getCart() async {
    cartList = [];
    for (var i = 0; i < cart!.cartList.length; i++) {
      cartList.add(cart!.cartList[i]);
    }
    await calculateTotalPrice();
    notifyListeners();
  }

  plusQuantity(CartModel only) async {
    cart!.plusQuantity(only);
    await calculateTotalPrice();
    notifyListeners();
  }

  minusQuantity(CartModel only) async {
    cart!.minusQuantity(only);
    await calculateTotalPrice();
    notifyListeners();
  }

  removeItem(CartModel only) async {
    cart!.removeItem(only);
    await getCart();
    notifyListeners();
  }

  calculateTotalPrice() {
    totalPrice = 0;
    for (var i = 0; i < cartList.length; i++) {
      num onlyPrice = (cartList[i].item.price ?? 0) * cartList[i].quantity;
      totalPrice = totalPrice + onlyPrice;
    }
    notifyListeners();
  }

  checkOut() {
    if (cartList.isNotEmpty) {
      var route = MaterialPageRoute(builder: (context) => CheckOutPage());
      Navigator.push(context, route);
    } else {
      ToastWidget(context).error(message: "No item in cart.");
    }
  }
}
