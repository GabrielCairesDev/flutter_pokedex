/// Classe que centraliza as URLs de endpoints da PokeAPI utilizadas na aplicação.
///
/// Esta classe contém as constantes e métodos necessários para montar
/// as URLs de requisição para buscar informações de espécies e detalhes dos Pokémon.
///
/// Exemplo de uso:
/// ```dart
/// String url = AppEnpoints.pokemonDetails(25); // Detalhes do Pikachu
/// ```
class AppEnpoints {
  /// Construtor privado para evitar instanciação.
  AppEnpoints._();

  static const String pokemonsSpeciesCount =
      'https://pokeapi.co/api/v2/pokemon-species/?limit=0';

  static String pokemonSpecies(int id) =>
      'https://pokeapi.co/api/v2/pokemon-species/$id';

  static String pokemonDetails(int id) =>
      'https://pokeapi.co/api/v2/pokemon/$id';
}
