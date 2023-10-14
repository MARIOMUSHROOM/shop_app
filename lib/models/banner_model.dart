// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  List<BannerItem>? bannerItems;

  BannerModel({
    this.bannerItems,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerItems: json["banner_items"] == null
            ? []
            : List<BannerItem>.from(
                json["banner_items"]!.map((x) => BannerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner_items": bannerItems == null
            ? []
            : List<dynamic>.from(bannerItems!.map((x) => x.toJson())),
      };
}

class BannerItem {
  int? id;
  String? imageUrl;

  BannerItem({
    this.id,
    this.imageUrl,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        id: json["id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}
