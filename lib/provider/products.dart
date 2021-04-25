import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Beats Solo3',
    //   description: "Input Type: 3.5mm stereo jack\n"
    //       "Other Features: Bluetooth, Foldable, Noise Isolation, Stereo, Stereo Bluetooth, Wireless\n"
    //       "Form Factor: On-Ear\n"
    //       "Connections: Bluetooth, Wireless\n"
    //       "Speaker Configurations: Stereo",
    //   price: 29.99,
    //   imagePath:
    //       'https://pororom.com/pub/media/catalog/product/cache/926507dc7f93631a094422215b778fe0/c/z/czxczccxewrre_2_.jpg',
    // ),
    // Product(
    //     id: 'p2',
    //     title: 'Beats Solo Pro',
    //     description: "Input Type: 3.5mm stereo jack\n"
    //         "Other Features: Bluetooth, Foldable, Noise Isolation, Stereo, Stereo Bluetooth, Wireless\n"
    //         "Form Factor: On-Ear\n"
    //         "Connections: Bluetooth, Wireless\n"
    //         "Speaker Configurations: Stereo",
    //     price: 59.99,
    //     imagePath:
    //         'https://media.sweetwater.com/api/i/q-82__ha-8d0a0c7ca2c685a9__hmac-1930840411a27ae7431512d7e8fc6c51e53e2929/images/items/750/Live500BTBk-large.jpg'),
    // Product(
    //   id: 'p3',
    //   title: 'Beats Solo',
    //   description: "Input Type: 3.5mm stereo jack\n"
    //       "Other Features: Bluetooth, Foldable, Noise Isolation, Stereo, Stereo Bluetooth, Wireless\n"
    //       "Form Factor: On-Ear\n"
    //       "Connections: Bluetooth, Wireless\n"
    //       "Speaker Configurations: Stereo",
    //   price: 19.99,
    //   imagePath:
    //       'https://images.yaoota.com/CsEeNG7A3aM8roUlzGSTq9ddbnY=/trim/yaootaweb-production-sa/media/crawledproductimages/551f27e4354bcfbac7a54c030d7c16ecb8434753.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Beats EP',
    //   description: "Input Type: 3.5mm stereo jack\n"
    //       "Other Features: Bluetooth, Foldable, Noise Isolation, Stereo, Stereo Bluetooth, Wireless\n"
    //       "Form Factor: On-Ear\n"
    //       "Connections: Bluetooth, Wireless\n"
    //       "Speaker Configurations: Stereo",
    //   price: 49.99,
    //   imagePath:
    //       'https://pororom.com/pub/media/catalog/product/cache/926507dc7f93631a094422215b778fe0/c/z/czxczccxewrre_2_.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoriteOnly {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        "https://my-shop-app-fd943-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if(extractedData == null){return;}
      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imagePath: productData['imageUrl'],
          ),
        );
      });
      _items=loadedProducts;
      notifyListeners();
      //print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product newProduct) {
    const String url =
        "https://my-shop-app-fd943-default-rtdb.firebaseio.com/products.json";
    return http
        .post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'price': newProduct.price,
        'description': newProduct.description,
        'imageUrl': newProduct.imagePath,
        'isFavorite': newProduct.isFavorite,
      }),
    )
        .then((response) {
      print(json.decode(response.body));
      newProduct = Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imagePath: newProduct.imagePath,
      );
      _items.add(newProduct);
      notifyListeners();
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final  url =
        "https://my-shop-app-fd943-default-rtdb.firebaseio.com/products/$id.json";
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      await http.patch(url,body: json.encode({
        'title':newProduct.title,
        'price':newProduct.price,
        'description':newProduct.description,
        'imageUrl':newProduct.imagePath,
      }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void removeProduct(String id) async{
    final  url =
        "https://my-shop-app-fd943-default-rtdb.firebaseio.com/products/$id.json";
    await http.delete(url);
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
