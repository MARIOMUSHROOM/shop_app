import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/banner_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/service/banner_api.dart';
import 'package:shop_app/service/product_api.dart';
import 'package:shop_app/widgets/toast_v3_widget.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.context);
  BuildContext context;
  FavoriteProvider? favorite;
  List<ProductItem> productList = [];
  List<ProductItem> productSearch = [];
  List<BannerItem>? bannerItems = [];
  TextEditingController search = TextEditingController();
  int index = 0;
  init() {
    favorite = Provider.of<FavoriteProvider>(context, listen: false);
    getProduct();
    getBanner();
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

  getBanner() async {
    try {
      var source = await BannerAPI().getBanner();
      var rs = json.decode(source);
      bannerItems = List<BannerItem>.from(
          rs["banner_items"]!.map((x) => BannerItem.fromJson(x)));
      notifyListeners();
    } catch (e) {
      print("e : $e");
      ToastWidget(context).error(message: "banner error");
    }
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

  sortByPrice() {
    productList.sort((a, b) => a.price!.compareTo(b.price!));
    notifyListeners();
  }

  searchText() {
    productSearch = productList.where((e) {
      return e.name!.contains(search.text);
    }).toList();
    notifyListeners();
  }

  setIndex(int indexCome) {
    index = indexCome;
    notifyListeners();
  }
}
