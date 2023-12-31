import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/core/constants/contants.dart';
import 'package:shop_app/core/error/exception.dart';
import 'package:shop_app/data/model/product_item_model.dart';

abstract class ProductDataSource {
  Future<ProductItem> getCurrentProduct();
  Future<ProductItemElement> getProductById(int id);
}

class ProductDataSourceImpl extends ProductDataSource {
  final http.Client client;
  ProductDataSourceImpl({required this.client});

  @override
  Future<ProductItem> getCurrentProduct() async {
    return ProductItem.fromJson(mockData);
    // final response =
    //     await client.get(Uri.parse("endPoint"));
    // if (response.statusCode == 200) {
    //   return ProductItem.fromJson(json.decode(response.body));
    // } else {
    //   throw ServerException();
    // }
  }

  @override
  Future<ProductItemElement> getProductById(int id) async {
    Map<String, dynamic> response = {};
    for (var i = 0; i < mockDataList.length; i++) {
      if (id == mockDataList[i]['id']) {
        response = mockDataList[i];
      }
    }
    if (response.isNotEmpty) {
      return ProductItemElement.fromJson(response);
    } else {
      throw ServerException();
    }
  }
}

Map<String, dynamic> mockData = {
  "product_items": [
    {
      "id": 1,
      "name": "T-Bone Slice 300g.",
      "image_url":
          "https://images.unsplash.com/photo-1551028150-64b9f398f678?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 250
    },
    {
      "id": 2,
      "name": "Eggs No.1 Pack 30",
      "image_url":
          "https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 149
    },
    {
      "id": 3,
      "name": "Frozen Atlantic Salmon 125g.",
      "image_url":
          "https://images.unsplash.com/photo-1599084993091-1cb5c0721cc6?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 98
    },
    {
      "id": 4,
      "name": "White Prawn 30pcs per kg.",
      "image_url":
          "https://images.unsplash.com/photo-1504309250229-4f08315f3b5c?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 299
    },
    {
      "id": 5,
      "name": "Broccoli 1kg.",
      "image_url":
          "https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 96
    },
    {
      "id": 6,
      "name": "Caabbage 3kg.",
      "image_url":
          "https://images.unsplash.com/photo-1611105637889-3afd7295bdbf?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 129
    },
    {
      "id": 7,
      "name": "Itambé natural milk 1L.",
      "image_url":
          "https://images.unsplash.com/photo-1563636619-e9143da7973b?auto=format&fit=crop&w=200&h=200&q=80",
      "price": 79
    }
  ]
};

List<Map<String, dynamic>> mockDataList = [
  {
    "id": 1,
    "name": "T-Bone Slice 300g.",
    "image_url":
        "https://images.unsplash.com/photo-1551028150-64b9f398f678?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 250
  },
  {
    "id": 2,
    "name": "Eggs No.1 Pack 30",
    "image_url":
        "https://images.unsplash.com/photo-1516448620398-c5f44bf9f441?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 149
  },
  {
    "id": 3,
    "name": "Frozen Atlantic Salmon 125g.",
    "image_url":
        "https://images.unsplash.com/photo-1599084993091-1cb5c0721cc6?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 98
  },
  {
    "id": 4,
    "name": "White Prawn 30pcs per kg.",
    "image_url":
        "https://images.unsplash.com/photo-1504309250229-4f08315f3b5c?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 299
  },
  {
    "id": 5,
    "name": "Broccoli 1kg.",
    "image_url":
        "https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 96
  },
  {
    "id": 6,
    "name": "Caabbage 3kg.",
    "image_url":
        "https://images.unsplash.com/photo-1611105637889-3afd7295bdbf?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 129
  },
  {
    "id": 7,
    "name": "Itambé natural milk 1L.",
    "image_url":
        "https://images.unsplash.com/photo-1563636619-e9143da7973b?auto=format&fit=crop&w=200&h=200&q=80",
    "price": 79
  }
];
