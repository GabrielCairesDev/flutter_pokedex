import 'package:flutter/material.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:get_it/get_it.dart';

class HomeViewModel extends ChangeNotifier {
  final PokemonRepository repository = GetIt.I.get<PokemonRepository>();
  final searchController = TextEditingController();

  List<PokemonModel> _pokemons = [];
  bool _isLoading = true;
  PokemonModel? selectedPokemon;

  List<PokemonModel> get pokemons {
    final searchText = searchController.text.trim().toLowerCase();
    final filtered = searchText.isEmpty
        ? _pokemons
        : _pokemons.where((p) {
            final nameMatches = p.name.toLowerCase().contains(searchText);
            final idMatches = p.id.toString().contains(searchText);
            return nameMatches || idMatches;
          }).toList();

    filtered.sort((a, b) => a.id.compareTo(b.id));
    return filtered;
  }

  bool get isLoading => _isLoading;
  bool get isFirst =>
      selectedPokemon != null && pokemons.indexOf(selectedPokemon!) == 0;
  bool get isLast =>
      selectedPokemon != null &&
      pokemons.indexOf(selectedPokemon!) == pokemons.length - 1;

  Future<void> init() async {
    _registerInGetIt();
    _setLoading(true);
    int quantity = await repository.fetchPokemonCount();
    _pokemons = await repository.fetchAllPokemons(quantity);
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void selectPokemon(PokemonModel pokemon) {
    selectedPokemon = pokemon;
    notifyListeners();
  }

  void nextPokemon() {
    final index = pokemons.indexOf(selectedPokemon!);
    if (index < pokemons.length - 1) {
      selectedPokemon = pokemons[index + 1];
      notifyListeners();
    }
  }

  void previousPokemon() {
    final index = pokemons.indexOf(selectedPokemon!);
    if (index > 0) {
      selectedPokemon = pokemons[index - 1];
      notifyListeners();
    }
  }

  void searching() => notifyListeners();

  void _registerInGetIt() {
    if (!GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.registerSingleton<HomeViewModel>(this);
    }
  }

  @override
  void dispose() {
    if (GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.unregister<HomeViewModel>();
    }
    super.dispose();
  }
}
