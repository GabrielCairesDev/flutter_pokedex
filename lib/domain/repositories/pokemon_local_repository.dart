import 'package:flutter_pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';

class PokemonLocalRepository {
  final PokemonLocalDatasource datasource = PokemonLocalDatasource();

  Future<void> savePokemons(List<PokemonModel> pokemons) async {
    await datasource.cachePokemons(pokemons);
  }

  Future<List<PokemonModel>> getAllPokemons() async {
    return await datasource.fetchAllPokemons();
  }

  Future<void> clearCache() async {
    await datasource.clearPokemons();
  }
}
