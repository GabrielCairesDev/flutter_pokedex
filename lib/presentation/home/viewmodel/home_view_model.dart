import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/constants/enpoints_constants.dart';
import 'package:flutter_pokedex/app/routes/app_routes.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  int _quantityPokemons = 0;
  final ValueNotifier<int> quantityPokemonsCaught = ValueNotifier<int>(0);

  bool _isLoading = true;
  final List<PokemonModel> _listPokemons = [];

  PokemonModel? pokemonSelected;

  List<PokemonModel> get listPokemons => _listPokemons;
  int get quantityPokemons => _quantityPokemons;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _registerInGetIt();
    _setLoading(true);
    await _fetchQuantityPokemons();
    await _fetchAllPokemons();
    _setLoading(false);
  }

  @override
  void dispose() {
    _unregisterFromGetIt();
    super.dispose();
  }

  void _registerInGetIt() {
    if (!GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.registerSingleton<HomeViewModel>(this);
    }
  }

  void _unregisterFromGetIt() {
    if (GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.unregister<HomeViewModel>();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _fetchQuantityPokemons() async {
    final url = Uri.parse(EnpointsConstants.pokemonsSpeciesCount);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _quantityPokemons = data['count'] ?? 0;
      } else {
        debugPrint(
          'Falha ao buscar quantidade de Pokémons. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Erro ao buscar quantidade de Pokémons: $e');
    }
  }

  Future<void> _fetchAllPokemons() async {
    _listPokemons.clear();
    const int batchSize = 100;

    for (int i = 1; i <= _quantityPokemons; i += batchSize) {
      final List<Future<PokemonModel?>> batchFutures = [];

      for (int j = i; j < i + batchSize && j <= _quantityPokemons; j++) {
        batchFutures.add(_fetchPokemonById(j));
      }

      final batchResults = await Future.wait(batchFutures);
      int pokemonsAdded = 0;

      for (var pokemon in batchResults) {
        if (pokemon != null) {
          _listPokemons.add(pokemon);
          pokemonsAdded++;
        }
      }

      quantityPokemonsCaught.value += pokemonsAdded;
    }
  }

  Future<PokemonModel?> _fetchPokemonById(int id) async {
    final url = Uri.parse(EnpointsConstants.pokemonDetails(id));

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PokemonModel.fromJson(data);
      } else {
        debugPrint(
          'Falha ao buscar Pokémon com ID $id. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Erro ao buscar Pokémon com ID $id: $e');
    }
    return null;
  }

  void setSelectedPokemon(BuildContext context, PokemonModel pokemon) {
    pokemonSelected = pokemon;
    Navigator.pushNamed(context, AppRoutes.pokemon);
  }
}
