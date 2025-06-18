import 'dart:collection';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/enpoints_constants.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  int _quantityPokemons = 0;
  final ValueNotifier<int> quantityPokemonsCaught = ValueNotifier<int>(0);
  bool _isLoading = true;
  final List<PokemonModel> _listPokemons = [];
  PokemonModel? pokemonSelected;

  List<PokemonModel> get listPokemons =>
      _listPokemons..sort((a, b) => a.id.compareTo(b.id));

  int get quantityPokemons => _quantityPokemons;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _registerInGetIt();
    _setLoading(true);
    await _fetchQuantityPokemons();
    await _fetchAllPokemonsWithConcurrencyLimit();
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
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _quantityPokemons = data['count'] ?? 0;
      }
    } catch (e) {
      debugPrint('Erro ao buscar quantidade de Pokémons: $e');
    }
  }

  Future<void> _fetchAllPokemonsWithConcurrencyLimit() async {
    _listPokemons.clear();
    const int maxConcurrent = 10; 
    final ids = List.generate(_quantityPokemons, (index) => index + 1);
    final queue = Queue<int>.from(ids);
    int caught = 0;

    Future<void> worker() async {
      while (queue.isNotEmpty) {
        final id = queue.removeFirst();
        final pokemon = await _fetchPokemonById(id);
        if (pokemon != null) {
          _listPokemons.add(pokemon);
          caught++;
        }
      }
    }

    final futures = List.generate(maxConcurrent, (_) => worker());
    await Future.wait(futures);

    quantityPokemonsCaught.value = caught;
  }

  Future<PokemonModel?> _fetchPokemonById(int id) async {
    final url = Uri.parse(EnpointsConstants.pokemonDetails(id));

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
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

        final description = await _fetchPokemonDescription(id);
        return PokemonModel.fromJson(
          data,
          initialMoves: initialMoves,
        ).copyWith(description: description);
      }
    } catch (e) {
      debugPrint('Erro ao buscar Pokémon ID $id: $e');
    }
    return null;
  }

  Future<String> _fetchPokemonDescription(int id) async {
    final url = Uri.parse(EnpointsConstants.pokemonSpecies(id));

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
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

  void selectPokemon(PokemonModel pokemon) {
    pokemonSelected = pokemon;
    notifyListeners();
  }
}
