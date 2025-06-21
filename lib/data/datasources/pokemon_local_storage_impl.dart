import 'dart:convert';
import 'package:flutter_pokedex/core/interfaces/storage_interface.dart';
import 'package:flutter_pokedex/core/exceptions/pokemon_exceptions.dart';
import 'package:flutter_pokedex/core/result/result.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_local_repository.dart';

/// Implementação do repositório de armazenamento local de Pokémon.
///
/// Utiliza [StorageInterface] para armazenar, carregar e limpar os dados
/// em cache localmente, no formato JSON, usando o padrão Result para
/// melhor tratamento de erros.
class PokemonLocalStorageImpl implements PokemonLocalStorageRepository {
  /// Interface de armazenamento utilizada para persistência.
  final StorageInterface _storage;

  /// Chave usada para armazenar os dados no storage.
  static const _storageKey = 'cached_pokemons';

  /// Construtor que recebe uma implementação de [StorageInterface].
  ///
  /// - [storage]: Interface de armazenamento a ser utilizada.
  PokemonLocalStorageImpl({required StorageInterface storage})
    : _storage = storage;

  /// Salva a lista de [PokemonModel] no armazenamento local.
  ///
  /// Os dados são convertidos para JSON antes de serem persistidos.
  ///
  /// - [pokemons]: Lista de modelos de Pokémon a serem salvos.
  @override
  Future<Result<void>> savePokemons(List<PokemonModel> pokemons) async {
    try {
      final encoded = jsonEncode(pokemons.map((p) => p.toJson()).toList());
      final success = await _storage.setString(_storageKey, encoded);

      if (success) {
        return const Result.success(null);
      } else {
        return Result.failure(
          StorageException(
            'Falha ao salvar Pokémons no armazenamento local',
            errorCode: 'SAVE_FAILED',
            details: {'pokemonCount': pokemons.length},
          ),
        );
      }
    } on PokemonException {
      rethrow;
    } catch (e) {
      return Result.failure(
        StorageException(
          'Erro inesperado ao salvar Pokémons: $e',
          errorCode: 'UNKNOWN_SAVE_ERROR',
          details: {
            'pokemonCount': pokemons.length,
            'originalError': e.toString(),
          },
        ),
      );
    }
  }

  /// Carrega os dados de Pokémon do cache local.
  ///
  /// - Retorna um [Result<List<PokemonModel>>] com os dados ou erro.
  @override
  Future<Result<List<PokemonModel>>> loadPokemons() async {
    try {
      final data = await _storage.getString(_storageKey);

      if (data == null) {
        return const Result.success([]);
      }

      final decoded = jsonDecode(data) as List<dynamic>;
      final pokemons = decoded
          .map(
            (item) => PokemonModel.fromCacheJson(item as Map<String, dynamic>),
          )
          .toList();

      return Result.success(pokemons);
    } on PokemonException {
      rethrow;
    } catch (e) {
      return Result.failure(
        StorageException(
          'Erro ao carregar Pokémons do cache: $e',
          errorCode: 'LOAD_ERROR',
          details: {'originalError': e.toString()},
        ),
      );
    }
  }

  /// Remove os dados de Pokémon salvos no armazenamento local.
  ///
  /// Útil para limpar o cache manualmente ou em casos de atualização.
  @override
  Future<Result<void>> clearPokemons() async {
    try {
      final success = await _storage.remove(_storageKey);

      if (success) {
        return const Result.success(null);
      } else {
        return Result.failure(
          StorageException(
            'Falha ao limpar cache de Pokémons',
            errorCode: 'CLEAR_FAILED',
          ),
        );
      }
    } on PokemonException {
      rethrow;
    } catch (e) {
      return Result.failure(
        StorageException(
          'Erro inesperado ao limpar cache: $e',
          errorCode: 'UNKNOWN_CLEAR_ERROR',
          details: {'originalError': e.toString()},
        ),
      );
    }
  }
}
