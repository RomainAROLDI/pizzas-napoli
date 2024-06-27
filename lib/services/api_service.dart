import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pizzas.shrp.dev'));

  Future<Response> getPizzas() async {
    return await _dio.get('/items/pizzas');
  }

  Future<Response> getPizzaDetails(String pizzaId) async {
    return await _dio.get('/items/pizzas/$pizzaId');
  }

  Future<Response> getPizzaIngredients() async {
    return await _dio.get('/items/pizzas_ingredients');
  }

  Future<Response> createUser(Map<String, dynamic> data) async {
    return await _dio.post('/auth/register', data: data);
  }

  Future<Response> loginUser(Map<String, dynamic> data) async {
    return await _dio.post('/auth/login', data: data);
  }

  Future<Response> getUserProfile() async {
    return await _dio.get('/users/me');
  }
}
