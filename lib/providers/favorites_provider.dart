import 'package:flutter/material.dart';
import '../models/pizza.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Pizza> _favorites = [];

  List<Pizza> get favorites => _favorites;

  void addFavorite(Pizza pizza) {
    _favorites.add(pizza);
    notifyListeners();
  }

  void removeFavorite(Pizza pizza) {
    _favorites.remove(pizza);
    notifyListeners();
  }

  bool isFavorite(Pizza pizza) {
    return _favorites.contains(pizza);
  }
}
