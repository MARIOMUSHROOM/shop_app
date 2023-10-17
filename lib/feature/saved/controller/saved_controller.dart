import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/service/product_api.dart';
import 'package:shop_app/widgets/toast_v3_widget.dart';

class SavedController extends ChangeNotifier {
  SavedController(this.context);
  BuildContext context;
  FavoriteProvider? favorite;
  CartProvider? cart;

  List<ProductItem> productList = [];
  var money = NumberFormat.currency(
      customPattern: "#,##0.00", locale: "th_TH", symbol: "");
  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context, listen: false);
    getFavorite();
  }

  getFavorite() {
    productList = [];
    for (var i = 0; i < favorite!.favoriteList.length; i++) {
      productList.add(favorite!.favoriteList[i]);
    }
    notifyListeners();
  }

  num getQuatity(int itemId) {
    return cart!.getQuantity(itemId);
  }

  removeWhere(ProductItem item) {
    favorite!.setProductToFavorite(item);
    ToastWidget(context).error(message: 'unsaved');
    getFavorite();
  }

  removeAll() {
    favorite!.removeAll();
    getFavorite();
  }
}
