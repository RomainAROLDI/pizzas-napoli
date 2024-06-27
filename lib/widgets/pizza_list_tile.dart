import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza.dart';
import '../providers/cart_provider.dart';

class PizzaListTile extends StatelessWidget {
  final Pizza pizza;

  const PizzaListTile({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://pizzas.shrp.dev/assets/${pizza.imageId}',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(pizza.name),
      subtitle: Text('${pizza.price} €'),
      trailing: IconButton(
        icon: const Icon(Icons.add_shopping_cart),
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).addToCart(pizza);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Added to cart'),
            duration: Duration(seconds: 1),
          ));
        },
      ),
    );
  }
}
