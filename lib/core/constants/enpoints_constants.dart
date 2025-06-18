class EnpointsConstants {
  EnpointsConstants._();

  static const String pokemonsSpeciesCount =
      'https://pokeapi.co/api/v2/pokemon-species/?limit=0';

  static String pokemonDetails(int id) =>
      'https://pokeapi.co/api/v2/pokemon/$id';
}
