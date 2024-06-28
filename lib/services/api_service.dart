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

  Future<Response> createUser(String email, String password) async {
    return await _dio.post('/users', data: {email, password});
  }

  Future<Response> loginUser(String email, String password) async {
    return await _dio.post('/auth/login', data: {email, password});
  }

  Future<Response> getUsers() async {
    return await _dio.get('/items/users');
  }
}
