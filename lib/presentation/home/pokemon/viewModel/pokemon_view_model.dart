import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/presentation/home/viewmodel/home_view_model.dart';
import 'package:get_it/get_it.dart';

class PokemonViewModel extends ChangeNotifier {
  HomeViewModel get _homeViewModel => GetIt.I.get<HomeViewModel>();

  PokemonModel get pokemonSelected => _homeViewModel.pokemonSelected!;
}
