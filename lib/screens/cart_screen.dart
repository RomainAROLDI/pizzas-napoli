import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre panier'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return cartProvider.cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.cartItems[index];
                    return ListTile(
                      leading: Image.network(
                        'https://pizzas.shrp.dev/assets/${item.pizza.imageId}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.pizza.name),
                      subtitle: Text(
                          '${item.pizza.price.toString()} € x ${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartProvider.removeFromCart(item.pizza);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cartProvider.addToCart(item.pizza);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ${cartProvider.totalPrice.toString()} €',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Commander'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
