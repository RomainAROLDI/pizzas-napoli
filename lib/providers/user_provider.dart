import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> fetchUsers() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.getUsers();
      _users = (response.data['data'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    } catch (e) {
      _error = 'Failed to fetch pizzas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  User? getUserById(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void deleteUserById(String id) {
    _users.removeWhere((user) => user.id == id);
    notifyListeners();
  }
}
