import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/pizza.dart';

class PizzaProvider with ChangeNotifier {
  List<Pizza> _pizzas = [];
  Pizza? _selectedPizza;

  List<Pizza> get pizzas => _pizzas;

  Pizza? get selectedPizza => _selectedPizza;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> fetchPizzas() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.getPizzas();
      _pizzas = (response.data['data'] as List)
          .map((pizza) => Pizza.fromJson(pizza))
          .toList();
    } catch (e) {
      _error = 'Failed to fetch pizzas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPizzaDetails(String pizzaId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.getPizzaDetails(pizzaId);
      _selectedPizza = Pizza.fromJson(response.data['data']);
    } catch (e) {
      _error = 'Failed to fetch pizza details: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
