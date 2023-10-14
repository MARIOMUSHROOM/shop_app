import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/service/product_api.dart';

class RecommendationController extends ChangeNotifier {
  RecommendationController(this.context);
  BuildContext context;
  List<ProductItem> productList = [];
  List<ProductItem> productSearch = [];
  TextEditingController search = TextEditingController();
  init() {
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

  searchText() {
    productSearch = productList.where((e) {
      return e.name!.contains(search.text);
    }).toList();
    notifyListeners();
  }

  sortByPrice() {
    productList.sort((a, b) => a.price!.compareTo(b.price!));
    notifyListeners();
  }
}
