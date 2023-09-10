// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<ProductItem>? productItems;

  ProductModel({
    this.productItems,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productItems: json["product_items"] == null
            ? []
            : List<ProductItem>.from(
                json["product_items"]!.map((x) => ProductItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_items": productItems == null
            ? []
            : List<dynamic>.from(productItems!.map((x) => x.toJson())),
      };
}

class ProductItem {
  int? id;
  String? name;
  String? imageUrl;
  num? price;

  ProductItem({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "price": price,
      };
}
