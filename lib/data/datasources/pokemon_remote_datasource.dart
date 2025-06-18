import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_endpoints.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:http/http.dart' as http;

class PokemonRemoteDatasource implements PokemonRepository {
  final http.Client client;

  PokemonRemoteDatasource({required this.client});

  @override
  Future<int> fetchPokemonCount() async {
    final url = Uri.parse(AppEnpoints.pokemonsSpeciesCount);
    try {
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['count'] ?? 0;
      }
    } catch (e) {
      debugPrint('Erro ao buscar quantidade de Pokémons: $e');
    }
    return 0;
  }

  @override
  Future<List<PokemonModel>> fetchAllPokemons() async {
    final quantity = await fetchPokemonCount();
    final List<PokemonModel> pokemons = [];
    const int maxConcurrent = 100;
    final queue = Queue<int>.from(
      List.generate(quantity, (index) => index + 1),
    );

    Future<void> worker() async {
      while (queue.isNotEmpty) {
        final id = queue.removeFirst();
        final pokemon = await fetchPokemonById(id);
        if (pokemon != null) {
          pokemons.add(pokemon);
        }
      }
    }

    final futures = List.generate(maxConcurrent, (_) => worker());
    await Future.wait(futures);

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

        return PokemonModel.fromJson(
          data,
          initialMoves: initialMoves,
          description: description,
        );
      }
    } catch (e) {
      debugPrint('Erro ao buscar Pokémon ID $id: $e');
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
            return (entry['flavor_text'] as String)
                .replaceAll('\n', ' ')
                .replaceAll('\f', ' ');
          }
        }
      }
    } catch (e) {
      debugPrint('Erro ao buscar descrição do Pokémon ID $id: $e');
    }
    return '';
  }
}
