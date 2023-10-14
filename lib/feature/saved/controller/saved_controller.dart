import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/service/product_api.dart';
import 'package:shop_app/widgets/toast_v3_widget.dart';

class SavedController extends ChangeNotifier {
  SavedController(this.context);
  BuildContext context;
  FavoriteProvider? favorite;
  List<ProductItem> productList = [];
  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    getFavorite();
  }

  getFavorite() {
    productList = [];
    for (var i = 0; i < favorite!.favoriteList.length; i++) {
      productList.add(favorite!.favoriteList[i]);
    }
    notifyListeners();
  }

  saveFavorite(ProductItem product) {
    favorite!.setProductToFavorite(product);
    bool selected = favorite!.thisProductInFavorite(product);
    if (selected) {
      ToastWidget(context).success(message: 'saved');
    } else {
      ToastWidget(context).error(message: 'unsaved');
    }
    getFavorite();
  }
}
