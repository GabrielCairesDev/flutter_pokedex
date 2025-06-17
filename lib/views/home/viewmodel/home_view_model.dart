import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/constants/enpoints_constants.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  int _qunatityPokemons = 0;
  final ValueNotifier<int> quantityPokemonsCaught = ValueNotifier<int>(0);

  bool _isLoading = true;

  final List<PokemonModel> _listPokemons = [];

  List<PokemonModel> get listPokemons => _listPokemons;

  PokemonModel? pokemonSelected;

  int get qunatityPokemons => _qunatityPokemons;

  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    await _getQuantityPokemons();
    await _getAllPokemons();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _getQuantityPokemons() async {
    final url = Uri.parse(EnpointsConstants.pokemonsSpeciesCount);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _qunatityPokemons = data['count'];
        debugPrint('Quantidade de Pokémons: $_qunatityPokemons');
      } else {
        debugPrint('Falha na requisição. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> _getAllPokemons() async {
    _listPokemons.clear();

    const int batchSize = 100;

    for (int i = 1; i <= _qunatityPokemons; i += batchSize) {
      final List<Future<PokemonModel?>> batchFutures = [];

      for (int j = i; j < i + batchSize && j <= _qunatityPokemons; j++) {
        batchFutures.add(_getPokemonById(j));
      }

      final List<PokemonModel?> batchResults = await Future.wait(batchFutures);

      int pokemonsAdicionados = 0;

      for (var pokemon in batchResults) {
        if (pokemon != null) {
          _listPokemons.add(pokemon);
          pokemonsAdicionados++;
        }
      }

      quantityPokemonsCaught.value += pokemonsAdicionados;
    }
  }

  Future<PokemonModel?> _getPokemonById(int id) async {
    final url = Uri.parse(EnpointsConstants.pokemonDetails(id));

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PokemonModel.fromJson(data);
      } else {
        debugPrint(
          'Falha ao buscar Pokémon $id. Status code: ${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('Erro ao buscar Pokémon $id: $e');
      return null;
    }
  }

  void setSelectedPokemon(BuildContext context, PokemonModel pokemon) {
    pokemonSelected = pokemon;
    print('Pokemon selecionado: ${pokemon.name}');
    notifyListeners();
  }
}
