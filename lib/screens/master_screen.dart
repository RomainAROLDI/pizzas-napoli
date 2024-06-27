import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/pizza_provider.dart';
import '../widgets/pizza_list_tile.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  MasterScreenState createState() => MasterScreenState();
}

class MasterScreenState extends State<MasterScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PizzaProvider>(context, listen: false).fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte des Pizzas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
      ),
      body: Consumer<PizzaProvider>(
        builder: (context, pizzaProvider, child) {
          if (pizzaProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (pizzaProvider.error != null) {
            return Center(child: Text('Error: ${pizzaProvider.error}'));
          } else if (pizzaProvider.pizzas.isEmpty) {
            return const Center(child: Text('Aucune pizza trouvée.'));
          } else {
            return ListView.builder(
              itemCount: pizzaProvider.pizzas.length,
              itemBuilder: (context, index) {
                final pizza = pizzaProvider.pizzas[index];
                return PizzaListTile(pizza: pizza);
              },
            );
          }
        },
      ),
    );
  }
}
