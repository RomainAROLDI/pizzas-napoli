import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/pizza.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  int _totalQuantity = 0;

  List<CartItem> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(
        0, (total, item) => total + item.pizza.price * item.quantity);
  }

  int get totalQuantity => _totalQuantity;

  void addToCart(Pizza pizza) {
    final index = _cartItems.indexWhere((item) => item.pizza.id == pizza.id);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(pizza: pizza));
    }
    _totalQuantity++;
    notifyListeners();
  }

  void removeFromCart(Pizza pizza) {
    final index = _cartItems.indexWhere((item) => item.pizza.id == pizza.id);
    if (index != -1) {
      _cartItems[index].quantity--;
      if (_cartItems[index].quantity <= 0) {
        _cartItems.removeAt(index);
      }
      _totalQuantity--;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _totalQuantity = 0;
    notifyListeners();
  }

  int getQuantity(String pizzaId) {
    final index = _cartItems.indexWhere((item) => item.pizza.id == pizzaId);

    return index != -1 ? _cartItems[index].quantity : 0;
  }
}
