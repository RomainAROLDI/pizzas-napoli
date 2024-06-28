import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pizzas.shrp.dev'));

  Future<Response> getPizzas() async {
    return await _dio
        .get('/items/pizzas?fields[]=*&fields[]=elements.ingredients_id.*');
  }

  Future<Response> getPizzaDetails(String pizzaId) async {
    return await _dio.get(
        '/items/pizzas/$pizzaId?fields[]=elements.ingredients_id.*&fields[]=*');
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
