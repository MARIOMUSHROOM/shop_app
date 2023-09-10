import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/service/product_api.dart';
import 'package:shop_app/widgets/toast_v2_widget.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.context);
  BuildContext context;
  FavoriteProvider? favorite;
  List<ProductItem> productList = [];
  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    getProduct();
  }

  getProduct() async {
    try {
      var source = await ProductAPI().getProduct();
      var rs = json.decode(source);
      productList = List<ProductItem>.from(
          rs["product_items"]!.map((x) => ProductItem.fromJson(x)));
      notifyListeners();
    } catch (e) {
      print("e : $e");
    }
  }

  saveFavorite(ProductItem product) {
    favorite!.setProductToFavorite(product);
    bool selected = favorite!.thisProductInFavorite(product);
    if (selected) {
      ToastWidget(context).successAction(text: 'saved');
    } else {
      ToastWidget(context).successAction(text: 'unsaved');
    }
    notifyListeners();
  }
}
