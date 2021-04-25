import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final double price;
  final String title;
  final int quantity;
  final String imagePath;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
    @required this.imagePath,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addToCart(
      String productId, double price, String title, String imagePath) {
    if (_items.containsKey(productId)) {
      _items.update(
        // if product already exist in the cart
        productId,
        (existingProduct) => CartItem(
          id: existingProduct.id,
          price: existingProduct.price,
          title: existingProduct.title,
          quantity: existingProduct.quantity + 1,
          imagePath: existingProduct.imagePath,
        ),
      );
    } else {
      // if the product is not in the cart at all
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
          imagePath: imagePath,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void undoSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
          imagePath: existingCartItem.imagePath,
        ),
      );
    }
     if (_items[productId].quantity==1){
      _items.remove(productId);
    }
     notifyListeners();
  }

  void decrementItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
          imagePath: existingCartItem.imagePath,
        ),
      );
    }
    notifyListeners();
  }
}
