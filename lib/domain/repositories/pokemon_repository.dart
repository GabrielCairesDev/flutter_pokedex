import '../../data/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<int> fetchPokemonCount();
  Future<List<PokemonModel>> fetchAllPokemons();
  Future<PokemonModel?> fetchPokemonById(int id);
  Future<String> fetchPokemonDescription(int id);
}
