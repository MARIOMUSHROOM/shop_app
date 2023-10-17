import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import "package:collection/collection.dart";

class FavoriteProvider extends ChangeNotifier {
  List<ProductItem> favoriteList = [];

  bool thisProductInFavorite(ProductItem product) {
    ProductItem? productItem = favoriteList.where((element) {
      return element.id == product.id;
    }).firstOrNull;
    if (productItem == null) {
      return false;
    } else {
      return true;
    }
  }

  setProductToFavorite(ProductItem product) {
    var check = thisProductInFavorite(product);
    if (!check) {
      favoriteList.add(product);
    } else {
      favoriteList.removeWhere((element) => element.id == product.id);
    }
    notifyListeners();
  }

  removeAll() {
    favoriteList = [];
    notifyListeners();
  }
}
