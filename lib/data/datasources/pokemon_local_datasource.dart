import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonLocalDatasource {
  static const String pokemonsKey = 'cached_pokemons';

  /// Salva a lista de Pokémons no cache
  Future<void> cachePokemons(List<PokemonModel> pokemons) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = pokemons
        .map((pokemon) => pokemon.toJson())
        .toList();
    await clearPokemons();
    await prefs.setString(pokemonsKey, jsonEncode(jsonList));
    debugPrint(
      '📤 (Local) ${pokemons.length} Pokémons salvos no cache com sucesso.',
    );
  }

  Future<List<PokemonModel>> fetchAllPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(pokemonsKey);

    if (jsonString != null) {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      final pokemons = decodedList
          .map(
            (json) => PokemonModel.fromCacheJson(json as Map<String, dynamic>),
          )
          .toList();

      debugPrint(
        '📥 (Local) ${pokemons.length} Pokémons recuperados do cache.',
      );
      return pokemons;
    }

    debugPrint('📥 (Local) Nenhum Pokémon encontrado no cache.');
    return [];
  }

  Future<void> clearPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(pokemonsKey);
    debugPrint('🗑️ (Local) Cache de Pokémons apagado com sucesso.');
  }
}
