class AppEnpoints {
  AppEnpoints._();

  static const String pokemonsSpeciesCount =
      'https://pokeapi.co/api/v2/pokemon-species/?limit=0';

  static String pokemonSpecies(int id) =>
      'https://pokeapi.co/api/v2/pokemon-species/$id';

  static String pokemonDetails(int id) =>
      'https://pokeapi.co/api/v2/pokemon/$id';
}
