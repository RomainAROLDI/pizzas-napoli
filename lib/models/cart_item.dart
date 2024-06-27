import 'package:pizzas_napoli/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem({required this.pizza, this.quantity = 1});
}
