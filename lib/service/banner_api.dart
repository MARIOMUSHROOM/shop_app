import 'dart:convert';

import 'package:http/http.dart' as http;

class BannerAPI {
  getBanner() {
    return json.encode(mockData);
  }
}

var mockData = {
  "banner_items": [
    {
      "id": 1,
      "image_url":
          "https://images.unsplash.com/photo-1606787366850-de6330128bfc?auto=format&fit=crop&w=500&h=200&q=80"
    },
    {
      "id": 2,
      "image_url":
          "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=500&h=200&q=80"
    },
    {
      "id": 3,
      "image_url":
          "https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?auto=format&fit=crop&w=500&h=200&q=80"
    },
    {
      "id": 4,
      "image_url":
          "https://images.unsplash.com/photo-1574484184081-afea8a62f9c0?auto=format&fit=crop&w=500&h=200&q=80"
    }
  ]
};
