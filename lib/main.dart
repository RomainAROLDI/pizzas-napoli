import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:pizzas_napoli/providers/auth_provider.dart';
import 'package:pizzas_napoli/providers/cart_provider.dart';
import 'package:pizzas_napoli/providers/favorites_provider.dart';
import 'package:pizzas_napoli/providers/pizza_provider.dart';
import 'package:pizzas_napoli/providers/user_provider.dart';
import 'package:pizzas_napoli/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PizzaProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: (context) => FavoritesProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: MaterialApp.router(
            routerConfig: router, title: 'Pizzas Napoli', theme: theme));
  }
}
