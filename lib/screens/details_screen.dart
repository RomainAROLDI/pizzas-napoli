import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzas_napoli/utils/number_formatter.dart';
import 'package:pizzas_napoli/widgets/ingredient_list.dart';
import 'package:provider/provider.dart';
import '../providers/pizza_provider.dart';
import '../models/pizza.dart';

class DetailsScreen extends StatefulWidget {
  final String pizzaId;

  const DetailsScreen({super.key, required this.pizzaId});

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<PizzaProvider>(context, listen: false)
          .fetchPizzaDetails(widget.pizzaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<PizzaProvider>(
          builder: (context, pizzaProvider, child) {
            return Text('${pizzaProvider.selectedPizza?.name ?? ''} - Détails');
          },
        ),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<PizzaProvider>(
        builder: (context, pizzaProvider, child) {
          if (pizzaProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (pizzaProvider.error != null) {
            return Center(child: Text('Error: ${pizzaProvider.error}'));
          } else {
            final Pizza? pizza = pizzaProvider.selectedPizza;

            if (pizza != null) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl:
                            'https://pizzas.shrp.dev/assets/${pizza.imageId}',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      pizza.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'Catégorie : ${pizza.category}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'Prix : ${formatNumber(pizza.price, 'fr_FR')} €',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(height: 0),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Liste des ingrédients :',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: IngredientList(ingredients: pizza.ingredients),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Oups, la Pizza a dû se perdre en chemin :/'),
              );
            }
          }
        },
      ),
    );
  }
}
