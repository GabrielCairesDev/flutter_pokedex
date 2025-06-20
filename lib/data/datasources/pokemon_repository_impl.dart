import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_endpoints.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:http/http.dart' as http;

/// Fonte de dados remota responsável por buscar informações de Pokémons através da PokeAPI.
///
/// Esta classe implementa o contrato definido pela interface [PokemonRepositoryImpl ],
/// realizando chamadas HTTP para obter dados como quantidade total de Pokémons,
/// detalhes individuais e descrições.
///
/// Exemplo de uso:
/// ```dart
/// final remoteDatasource = PokemonRemoteDatasource(client: http.Client());
/// final count = await remoteDatasource.fetchPokemonCount();
/// ```
class PokemonRepositoryImpl implements PokemonRepository {
  /// Cliente HTTP usado para realizar as requisições.
  final http.Client client;

  /// Construtor que recebe um [http.Client] para facilitar injeção de dependência e testes.
  PokemonRepositoryImpl({required this.client});

  @override
  Future<int> fetchPokemonCount() async {
    final url = Uri.parse(AppEnpoints.pokemonsSpeciesCount);
    try {
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final count = data['count'] ?? 0;
        debugPrint('✅ Quantidade de Pokémons recuperada com sucesso: $count');
        return count;
      }
    } catch (e) {
      debugPrint('❌ Erro ao buscar quantidade de Pokémons: $e');
    }
    return 0;
  }

  @override
  Future<List<PokemonModel>> fetchAllPokemons(int quantity) async {
    final List<PokemonModel> pokemons = [];
    const int maxConcurrent = 100;

    // Fila com os IDs dos Pokémons a serem buscados
    final queue = Queue<int>.from(
      List.generate(quantity, (index) => index + 1),
    );

    debugPrint('🔄 Iniciando busca de $quantity Pokémons...');

    // Função que processa os IDs da fila (trabalhador)
    Future<void> worker() async {
      while (queue.isNotEmpty) {
        final id = queue.removeFirst();
        final pokemon = await fetchPokemonById(id);
        if (pokemon != null) {
          pokemons.add(pokemon);
          debugPrint('✅ Pokémon ID $id carregado com sucesso.');
        }
      }
    }

    // Executa múltiplos workers de forma concorrente
    final futures = List.generate(maxConcurrent, (_) => worker());
    await Future.wait(futures);

    debugPrint(
      '🏁 Finalizada a busca de Pokémons. Total carregados: ${pokemons.length}',
    );
    return pokemons;
  }

  @override
  Future<PokemonModel?> fetchPokemonById(int id) async {
    final url = Uri.parse(AppEnpoints.pokemonDetails(id));

    try {
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));
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

        final description = await fetchPokemonDescription(id);

        debugPrint('✅ Dados do Pokémon ID $id recuperados com sucesso.');

        return PokemonModel.fromJson(
          data,
          initialMoves: initialMoves,
          description: description,
        );
      } else {
        debugPrint(
          '⚠️ Falha ao buscar detalhes do Pokémon ID $id. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('❌ Erro ao buscar Pokémon ID $id: $e');
    }
    return null;
  }

  @override
  Future<String> fetchPokemonDescription(int id) async {
    final url = Uri.parse(AppEnpoints.pokemonSpecies(id));

    try {
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final flavorEntries = data['flavor_text_entries'] as List;
        for (var entry in flavorEntries) {
          if (entry['language']['name'] == 'en') {
            final description = (entry['flavor_text'] as String)
                .replaceAll('\n', ' ')
                .replaceAll('\f', ' ');
            debugPrint('✅ Descrição do Pokémon ID $id recuperada com sucesso.');
            return description;
          }
        }
        debugPrint(
          '⚠️ Nenhuma descrição em inglês encontrada para Pokémon ID $id.',
        );
      } else {
        debugPrint(
          '⚠️ Falha ao buscar descrição do Pokémon ID $id. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('❌ Erro ao buscar descrição do Pokémon ID $id: $e');
    }
    return '';
  }
}
