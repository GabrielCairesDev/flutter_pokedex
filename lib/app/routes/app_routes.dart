import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/pokemon/view/pokemon_view.dart';
import 'package:flutter_pokedex/presentation/home/view/home_view.dart';

class AppRoutes {
  AppRoutes._();
  static const String home = '/home';
  static const String pokemon = '/pokemon';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => HomeView(),
    pokemon: (context) => const PokemonView(),
  };
}
