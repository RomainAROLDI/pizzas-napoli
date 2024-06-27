import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:pizzas_napoli/providers/pizza_provider.dart';
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
          ChangeNotifierProvider(create: (_) => PizzaProvider()),
        ],
        child: MaterialApp.router(
            routerConfig: router, title: 'Pizzas Napoli', theme: theme));
  }
}
