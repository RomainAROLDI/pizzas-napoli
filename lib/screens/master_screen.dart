import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzas_napoli/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../providers/pizza_provider.dart';
import '../providers/cart_provider.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<PizzaProvider>(context, listen: false).fetchPizzas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte des Pizzas'),
        leading:
            Consumer<AuthProvider>(builder: (context, authProvider, child) {
          if (authProvider.currentUser == null) {
            return IconButton(
              onPressed: () => context.go('/signin'),
              icon: const Icon(Icons.login_outlined),
            );
          }

          return IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.person),
          );
        }),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              int itemCount = cartProvider.totalQuantity;

              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go('/cart');
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          child: Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
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
