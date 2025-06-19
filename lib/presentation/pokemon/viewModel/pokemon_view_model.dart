import 'package:flutter/material.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/presentation/home/viewmodel/home_view_model.dart';
import 'package:get_it/get_it.dart';

/// ViewModel responsável por gerenciar o estado e a navegação dentro da tela de detalhes de um Pokémon.
///
/// Essa classe é uma ponte entre a [PokemonView] (UI) e o estado global gerenciado pelo [HomeViewModel].
///
/// Sua principal função é fornecer os dados do Pokémon atualmente selecionado
/// e controlar a navegação entre Pokémons (próximo/anterior).
class PokemonViewModel extends ChangeNotifier {
  /// Instância do [HomeViewModel] recuperada via GetIt para acessar o estado global.
  HomeViewModel get _homeViewModel => GetIt.I.get<HomeViewModel>();

  /// Pokémon atualmente selecionado.
  ///
  /// Este Pokémon será exibido na tela de detalhes.
  PokemonModel get pokemonSelected => _homeViewModel.selectedPokemon!;

  /// Indica se o Pokémon selecionado é o primeiro da lista.
  bool get isFirstPokemon => _homeViewModel.isFirst;

  /// Indica se o Pokémon selecionado é o último da lista.
  bool get isLastPokemon => _homeViewModel.isLast;

  /// Avança para o próximo Pokémon da lista.
  ///
  /// Exemplo de uso:
  /// ```dart
  /// viewModel.selectPokemonNext();
  /// ```
  void selectPokemonNext() {
    _homeViewModel.nextPokemon();
    notifyListeners();
  }

  /// Volta para o Pokémon anterior da lista.
  ///
  /// Exemplo de uso:
  /// ```dart
  /// viewModel.selectPokemonPrevious();
  /// ```
  void selectPokemonPrevious() {
    _homeViewModel.previousPokemon();
    notifyListeners();
  }
}
