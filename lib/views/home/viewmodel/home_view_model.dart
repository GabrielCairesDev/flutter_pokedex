import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/constants/enpoints_constants.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  int qunatityPokemons = 0;
  List<PokemonModel> listPokemons = [];

  Future<void> init() async {
    await _getQuantityPokemons();
    await _getAllPokemons();
  }

  Future<void> _getQuantityPokemons() async {
    final url = Uri.parse(EnpointsConstants.pokemonsSpeciesCount);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        qunatityPokemons = data['count'];
        debugPrint('Quantidade de Pokémons: $qunatityPokemons');
      } else {
        debugPrint('Falha na requisição. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
    }
  }

  Future<void> _getAllPokemons() async {
    listPokemons.clear();

    for (int i = 1; i <= qunatityPokemons; i++) {
      final pokemon = await _getPokemonById(i);

      if (pokemon != null) {
        listPokemons.add(pokemon);
        debugPrint('$i Pokémon adicionado: ${pokemon.name}');
      }
    }

    notifyListeners();
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
}
