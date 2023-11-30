import 'dart:convert';

import 'package:shop_app/domain/entities/product_item.dart';

ProductItem productItemFromJson(String str) =>
    ProductItem.fromJson(json.decode(str));

String productItemToJson(ProductItem data) => json.encode(data.toJson());

class ProductItem {
  List<ProductItemElement>? productItems;

  ProductItem({
    this.productItems,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        productItems: json["product_items"] == null
            ? []
            : List<ProductItemElement>.from(json["product_items"]!
                .map((x) => ProductItemElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_items": productItems == null
            ? []
            : List<dynamic>.from(productItems!.map((x) => x.toJson())),
      };
}

class ProductItemElement {
  int id;
  String name;
  String imageUrl;
  int price;

  ProductItemElement({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory ProductItemElement.fromJson(Map<String, dynamic> json) =>
      ProductItemElement(
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

  ProductItemEntity toEntity() => ProductItemEntity(
        id: id,
        name: name,
        imageUrl: imageUrl,
        price: price,
      );
}
