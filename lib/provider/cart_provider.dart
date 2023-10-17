import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import "package:collection/collection.dart";

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];

  bool thisProductInCart(ProductItem product) {
    bool check = cartList.where((element) {
      return element.item.id == product.id;
    }).isNotEmpty;
    return check;
  }

  addProductToCart(ProductItem product) {
    var inCart = thisProductInCart(product);
    if (inCart) {
      CartModel item = cartList.where((element) {
        return element.item.id == product.id;
      }).first;
      item.quantity = item.quantity + 1;
    } else {
      CartModel item = CartModel(item: product, quantity: 1);
      cartList.add(item);
    }
    notifyListeners();
  }

  num getQuantity(int itemId) {
    num quatity = 0;
    CartModel? item = cartList.where((element) {
      return element.item.id == itemId;
    }).firstOrNull;
    if (item != null) {
      quatity = item.quantity;
    }
    return quatity;
  }

  plusQuantity(CartModel only) {
    CartModel item = cartList.where((element) {
      return element.item.id == only.item.id;
    }).first;
    item.quantity = item.quantity + 1;
  }

  minusQuantity(CartModel only) {
    CartModel item = cartList.where((element) {
      return element.item.id == only.item.id;
    }).first;
    if (item.quantity > 1) {
      item.quantity = item.quantity - 1;
    }
  }

  removeItem(CartModel only) {
    CartModel item = cartList.where((element) {
      return element.item.id == only.item.id;
    }).first;
    cartList.remove(item);
  }
}

class CartModel {
  ProductItem item;
  num quantity;

  CartModel({
    required this.item,
    required this.quantity,
  });
}
