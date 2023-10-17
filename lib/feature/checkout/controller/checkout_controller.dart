import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/service/product_api.dart';

class CheckoutController extends ChangeNotifier {
  CheckoutController(this.context);
  BuildContext context;
  FavoriteProvider? favorite;
  CartProvider? cart;

  List<CartModel> cartList = [];
  num totalPrice = 0;
  var money = NumberFormat.currency(
      customPattern: "#,##0.00", locale: "th_TH", symbol: "");
  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context, listen: false);
    getCart();
    calculateTotalPrice();
  }

  getCart() async {
    cartList = cart!.cartList;
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
}
