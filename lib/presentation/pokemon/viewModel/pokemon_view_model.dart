import 'package:flutter/material.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/presentation/home/viewmodel/home_view_model.dart';
import 'package:get_it/get_it.dart';

class PokemonViewModel extends ChangeNotifier {
  HomeViewModel get _homeViewModel => GetIt.I.get<HomeViewModel>();

  PokemonModel get pokemonSelected => _homeViewModel.selectedPokemon!;

  bool get isFirstPokemon => _homeViewModel.isFirst;
  bool get isLastPokemon => _homeViewModel.isLast;

  void selectPokemonNext() {
    _homeViewModel.nextPokemon();
    notifyListeners();
  }

  void selectPokemonPrevious() {
    _homeViewModel.previousPokemon();
    notifyListeners();
  }
}
