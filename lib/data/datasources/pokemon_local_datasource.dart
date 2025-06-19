import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fonte de dados local responsável por armazenar e recuperar Pokémons do cache.
///
/// Utiliza o [SharedPreferences] para salvar e buscar a lista de Pokémons
/// de forma persistente entre sessões do aplicativo.
///
/// As operações são realizadas de forma assíncrona.
///
/// Exemplo de uso:
/// ```dart
/// final localDatasource = PokemonLocalDatasource();
/// await localDatasource.cachePokemons(listaDePokemons);
/// final pokemons = await localDatasource.fetchAllPokemons();
/// await localDatasource.clearPokemons();
/// ```
class PokemonLocalDatasource {
  /// Chave utilizada no [SharedPreferences] para armazenar os Pokémons.
  static const String pokemonsKey = 'cached_pokemons';

  /// Salva uma lista de Pokémons no cache local.
  ///
  /// - Antes de salvar, limpa qualquer cache anterior.
  /// - Cada [PokemonModel] é convertido em JSON.
  ///
  /// Parâmetros:
  /// - [pokemons]: Lista de Pokémons a serem cacheados.
  ///
  /// Exemplo:
  /// ```dart
  /// await cachePokemons(minhaListaDePokemons);
  /// ```
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

  /// Recupera todos os Pokémons armazenados no cache local.
  ///
  /// Retorna:
  /// - Uma lista de [PokemonModel] recuperada do armazenamento local.
  /// - Uma lista vazia caso não exista cache salvo.
  ///
  /// Exemplo:
  /// ```dart
  /// List<PokemonModel> pokemons = await fetchAllPokemons();
  /// ```
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

  /// Limpa o cache local, removendo todos os Pokémons armazenados.
  ///
  /// Exemplo:
  /// ```dart
  /// await clearPokemons();
  /// ```
  Future<void> clearPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(pokemonsKey);
    debugPrint('🗑️ (Local) Cache de Pokémons apagado com sucesso.');
  }
}
