import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/pizza.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(
        0, (total, item) => total + item.pizza.price * item.quantity);
  }

  void addToCart(Pizza pizza) {
    final index = _cartItems.indexWhere((item) => item.pizza.id == pizza.id);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(pizza: pizza));
    }
    notifyListeners();
  }

  void removeFromCart(Pizza pizza) {
    final index = _cartItems.indexWhere((item) => item.pizza.id == pizza.id);
    if (index != -1) {
      _cartItems[index].quantity--;
      if (_cartItems[index].quantity <= 0) {
        _cartItems.removeAt(index);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
