import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> signUp(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.createUser(email, password);
      if (response.statusCode == 201) {
        print(response.data);
        signIn(email, password);
      }
    } catch (e) {
      _error = 'Failed to fetch sign up: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.loginUser(email, password);
      if (response.statusCode == 200) {
        _currentUser = response.data;
      }
    } catch (e) {
      _error = 'Failed to fetch sign in: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
  }
}
