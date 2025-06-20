import 'dart:convert';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementação do repositório de armazenamento local de Pokémon.
///
/// Utiliza `SharedPreferences` para armazenar, carregar e limpar os dados
/// em cache localmente, no formato JSON.
class PokemonLocalStorageImpl implements PokemonLocalStorageRepository {
  /// Chave usada para armazenar os dados no `SharedPreferences`.
  static const _storageKey = 'cached_pokemons';

  /// Salva a lista de [PokemonModel] no armazenamento local.
  ///
  /// Os dados são convertidos para JSON antes de serem persistidos.
  ///
  /// - [pokemons]: Lista de modelos de Pokémon a serem salvos.
  @override
  Future<void> savePokemons(List<PokemonModel> pokemons) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(pokemons.map((p) => p.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  /// Carrega os dados de Pokémon do cache local.
  ///
  /// Retorna uma lista de [PokemonModel] ou uma lista vazia
  /// se não houver dados salvos ou se houver erro na leitura/conversão.
  @override
  Future<List<PokemonModel>> loadPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);

    if (data == null) return [];

    try {
      final decoded = jsonDecode(data) as List<dynamic>;
      return decoded
          .map(
            (item) => PokemonModel.fromCacheJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      // Retorna lista vazia caso haja erro na conversão do JSON.
      return [];
    }
  }

  /// Remove os dados de Pokémon salvos no armazenamento local.
  ///
  /// Útil para limpar o cache manualmente ou em casos de atualização.
  @override
  Future<void> clearPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
