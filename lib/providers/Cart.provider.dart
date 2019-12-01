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

  void removeSingleItem(String productID) {
    if (!_cartItems.containsKey(productID)) {
      return;
    }
    if (_cartItems[productID].quantity > 1) {
      _cartItems.update(
          productID,
          (existing) => CartItem(
              title: existing.title,
              id: existing.id,
              price: existing.price,
              quantity: existing.quantity - 1));
    } else {
      _cartItems.remove(productID);
    }

    notifyListeners();
  }
}
