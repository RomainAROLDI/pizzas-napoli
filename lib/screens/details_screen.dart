import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pizza_provider.dart';
import '../models/pizza.dart';

class DetailsScreen extends StatelessWidget {
  final String pizzaId;

  const DetailsScreen({super.key, required this.pizzaId});

  @override
  Widget build(BuildContext context) {
    final pizzaProvider = Provider.of<PizzaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
      ),
      body: FutureBuilder(
        future: pizzaProvider.fetchPizzaDetails(pizzaId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final Pizza pizza = pizzaProvider.selectedPizza!;
            return Column(
              children: [
                Image.network(pizza.imageId),
                Text(pizza.name, style: const TextStyle(fontSize: 24)),
                Text(pizza.category),
                Text('Price: \$${pizza.price.toString()}'),
                // Display ingredients, etc.
              ],
            );
          }
        },
      ),
    );
  }
}
