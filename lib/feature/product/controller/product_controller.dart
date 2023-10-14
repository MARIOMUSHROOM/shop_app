import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/service/product_api.dart';
import 'package:shop_app/widgets/toast_v3_widget.dart';

class ProductController extends ChangeNotifier {
  ProductController(this.context, {required this.product});
  BuildContext context;
  FavoriteProvider? favorite;
  CartProvider? cart;
  ProductItem product;

  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context, listen: false);
  }

  saveFavorite(ProductItem product) {
    favorite!.setProductToFavorite(product);
    bool selected = favorite!.thisProductInFavorite(product);
    if (selected) {
      ToastWidget(context).success(message: 'saved');
    } else {
      ToastWidget(context).error(message: 'unsaved');
    }
    notifyListeners();
  }

  addToCart(ProductItem product) {
    cart!.addProductToCart(product);
    ToastWidget(context).success(message: 'added');
    notifyListeners();
  }
}
