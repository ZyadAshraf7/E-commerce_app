import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imagePath;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imagePath,
      this.isFavorite=false
      });

  Future<void> toggleFavorite()async{
    final  url =
        "https://my-shop-app-fd943-default-rtdb.firebaseio.com/products/$id.json";
    isFavorite = !isFavorite;
    await http.patch(url,body: json.encode({
      'isFavorite':isFavorite,
    }));
    notifyListeners();
  }

}
