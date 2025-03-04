import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzas_napoli/utils/number_formatter.dart';
import 'package:provider/provider.dart';
import '../models/pizza.dart';
import '../providers/cart_provider.dart';

class PizzaListTile extends StatelessWidget {
  final Pizza pizza;

  const PizzaListTile({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/details/${pizza.id}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColor,
              width: .2,
            ),
          ),
          color: Colors.white60,
        ),
        child: ListTile(
          leading: SizedBox(
            width: 50,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: 'https://pizzas.shrp.dev/assets/${pizza.imageId}',
              fit: BoxFit.contain,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(pizza.name),
          ),
          subtitle: Text('${formatNumber(pizza.price, 'fr_FR')} €'),
          trailing: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              int itemQty = cartProvider.getQuantity(pizza.id);
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (itemQty > 0)
                    Text(
                      itemQty.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(pizza);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pizza ${pizza.name} ajouté au panier',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    color: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
