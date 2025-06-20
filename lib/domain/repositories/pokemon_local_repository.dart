import 'package:flutter_pokedex/data/models/pokemon_model.dart';

/// Contrato para o repositório de armazenamento local de Pokémon.
///
/// Define as operações básicas de cache que devem ser implementadas
/// por qualquer classe responsável por persistência local dos dados.
abstract class PokemonLocalStorageRepository {
  /// Salva uma lista de [PokemonModel] localmente.
  ///
  /// Deve sobrescrever qualquer cache anterior.
  /// - [pokemons]: Lista de pokémons a ser armazenada.
  Future<void> savePokemons(List<PokemonModel> pokemons);

  /// Carrega a lista de [PokemonModel] previamente salva localmente.
  ///
  /// Retorna uma lista vazia se não houver dados disponíveis ou se ocorrer falha na leitura.
  Future<List<PokemonModel>> loadPokemons();

  /// Limpa todos os dados de pokémons salvos localmente.
  ///
  /// Útil para cenários como logout, reinicialização de dados ou sincronização forçada.
  Future<void> clearPokemons();
}
