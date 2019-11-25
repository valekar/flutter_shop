import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({this.id, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return _cartItems;
  }

  void addItem(String productID, double price, String title) {
    if (_cartItems.containsKey(productID)) {
      _cartItems.update(
        productID,
        (existingItem) => CartItem(
          quantity: existingItem.quantity + 1,
          title: title,
          price: price,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }

    notifyListeners();
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clear() {
    _cartItems = {};
    notifyListeners();
  }
}
