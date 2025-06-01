import 'package:flutter/material.dart';
import 'package:flutter_pokedex/views/home/home_view.dart';

class AppConfig extends StatelessWidget {
  const AppConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Pokedex PokeApi', home: HomeView());
  }
}
