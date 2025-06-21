import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_endpoints.dart';
import 'package:flutter_pokedex/core/interfaces/http_client_interface.dart';
import 'package:flutter_pokedex/core/exceptions/pokemon_exceptions.dart';
import 'package:flutter_pokedex/core/result/result.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';

/// Fonte de dados remota responsável por buscar informações de Pokémons através da PokeAPI.
///
/// Esta classe implementa o contrato definido pela interface [PokemonRepository],
/// realizando chamadas HTTP para obter dados como quantidade total de Pokémons,
/// detalhes individuais e descrições, usando o padrão Result para melhor tratamento de erros.
///
/// Exemplo de uso:
/// ```dart
/// final remoteDatasource = PokemonRepositoryImpl(client: httpClient);
/// final result = await remoteDatasource.fetchPokemonCount();
/// result.when(
///   success: (count) => print('Total: $count'),
///   failure: (error) => print('Erro: ${error.message}'),
/// );
/// ```
class PokemonRepositoryImpl implements PokemonRepository {
  /// Cliente HTTP usado para realizar as requisições.
  final HttpClientInterface client;

  /// Construtor que recebe um [HttpClientInterface] para facilitar injeção de dependência e testes.
  PokemonRepositoryImpl({required this.client});

  @override
  Future<Result<int>> fetchPokemonCount() async {
    final url = Uri.parse(AppEnpoints.pokemonsSpeciesCount);
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final count = data['count'] ?? 0;
        debugPrint('✅ Quantidade de Pokémons recuperada com sucesso: $count');
        return Result.success(count);
      } else {
        return Result.failure(
          ApiException(
            'Falha ao buscar quantidade de Pokémons. Status: ${response.statusCode}',
            statusCode: response.statusCode,
            errorCode: 'FETCH_COUNT_ERROR',
            details: {'url': url.toString(), 'response': response.body},
          ),
        );
      }
    } on PokemonException {
      rethrow;
    } catch (e) {
      return Result.failure(
        NetworkException(
          'Erro inesperado ao buscar quantidade de Pokémons: $e',
          errorCode: 'UNKNOWN_ERROR',
          details: {'url': url.toString(), 'originalError': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Result<List<PokemonModel>>> fetchAllPokemons(int quantity) async {
    final List<PokemonModel> pokemons = [];
    const int maxConcurrent = 100;

    // Fila com os IDs dos Pokémons a serem buscados
    final queue = Queue<int>.from(
      List.generate(quantity, (index) => index + 1),
    );

    debugPrint('🔄 Iniciando busca de $quantity Pokémons...');

    try {
      // Função que processa os IDs da fila (trabalhador)
      Future<void> worker() async {
        while (queue.isNotEmpty) {
          final id = queue.removeFirst();
          final result = await fetchPokemonById(id);

          result.when(
            success: (pokemon) {
              if (pokemon != null) {
                pokemons.add(pokemon);
                debugPrint('✅ Pokémon ID $id carregado com sucesso.');
              }
            },
            failure: (error) {
              debugPrint('❌ Erro ao carregar Pokémon ID $id: ${error.message}');
            },
          );
        }
      }

      // Executa múltiplos workers de forma concorrente
      final futures = List.generate(maxConcurrent, (_) => worker());
      await Future.wait(futures);

      debugPrint(
        '🏁 Finalizada a busca de Pokémons. Total carregados: ${pokemons.length}',
      );

      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        NetworkException(
          'Erro durante busca em lote de Pokémons: $e',
          errorCode: 'BATCH_FETCH_ERROR',
          details: {'quantity': quantity, 'originalError': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Result<PokemonModel?>> fetchPokemonById(int id) async {
    final url = Uri.parse(AppEnpoints.pokemonDetails(id));

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<String> initialMoves = [];

        // Filtra os golpes aprendidos no nível 1 por level-up
        for (var move in data['moves']) {
          for (var detail in move['version_group_details']) {
            final learnMethod = detail['move_learn_method']['name'];
            final levelLearnedAt = detail['level_learned_at'];
            if (learnMethod == 'level-up' && levelLearnedAt == 1) {
              initialMoves.add(move['move']['name']);
            }
          }
        }

        final descriptionResult = await fetchPokemonDescription(id);
        final description = descriptionResult.getOrElse('');

        debugPrint('✅ Dados do Pokémon ID $id recuperados com sucesso.');

        return Result.success(
          PokemonModel.fromJson(
            data,
            initialMoves: initialMoves,
            description: description,
          ),
        );
      } else if (response.statusCode == 404) {
        return Result.failure(
          PokemonNotFoundException(
            'Pokémon com ID $id não encontrado',
            pokemonId: id,
            errorCode: 'POKEMON_NOT_FOUND',
            details: {'url': url.toString()},
          ),
        );
      } else {
        return Result.failure(
          ApiException(
            'Falha ao buscar detalhes do Pokémon ID $id. Status: ${response.statusCode}',
            statusCode: response.statusCode,
            errorCode: 'FETCH_POKEMON_ERROR',
            details: {
              'url': url.toString(),
              'response': response.body,
              'pokemonId': id,
            },
          ),
        );
      }
    } on PokemonException {
      rethrow;
    } catch (e) {
      return Result.failure(
        NetworkException(
          'Erro inesperado ao buscar Pokémon ID $id: $e',
          errorCode: 'UNKNOWN_ERROR',
          details: {
            'url': url.toString(),
            'pokemonId': id,
            'originalError': e.toString(),
          },
        ),
      );
    }
  }

  @override
  Future<Result<String>> fetchPokemonDescription(int id) async {
    final url = Uri.parse(AppEnpoints.pokemonSpecies(id));

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final flavorEntries = data['flavor_text_entries'] as List;

        for (var entry in flavorEntries) {
          if (entry['language']['name'] == 'en') {
            final description = (entry['flavor_text'] as String)
                .replaceAll('\n', ' ')
                .replaceAll('\f', ' ');
            debugPrint('✅ Descrição do Pokémon ID $id recuperada com sucesso.');
            return Result.success(description);
          }
        }

        return Result.failure(
          DataParsingException(
            'Nenhuma descrição em inglês encontrada para Pokémon ID $id',
            errorCode: 'NO_DESCRIPTION_FOUND',
            rawData: data,
            details: {'url': url.toString(), 'pokemonId': id},
          ),
        );
      } else if (response.statusCode == 404) {
        return Result.failure(
          PokemonNotFoundException(
            'Espécie do Pokémon com ID $id não encontrada',
            pokemonId: id,
            errorCode: 'SPECIES_NOT_FOUND',
            details: {'url': url.toString()},
          ),
        );
      } else {
        return Result.failure(
          ApiException(
            'Falha ao buscar descrição do Pokémon ID $id. Status: ${response.statusCode}',
            statusCode: response.statusCode,
            errorCode: 'FETCH_DESCRIPTION_ERROR',
            details: {'url': url.toString(), 'response': response.body},
          ),
        );
      }
    } on PokemonException {
      rethrow;
    } catch (e) {
      return Result.failure(
        NetworkException(
          'Erro inesperado ao buscar descrição do Pokémon ID $id: $e',
          errorCode: 'UNKNOWN_ERROR',
          details: {
            'url': url.toString(),
            'pokemonId': id,
            'originalError': e.toString(),
          },
        ),
      );
    }
  }
}
