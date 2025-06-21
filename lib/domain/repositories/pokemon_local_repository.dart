import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/core/result/result.dart';

/// Contrato para o repositório de armazenamento local de Pokémon.
///
/// Define as operações básicas de cache que devem ser implementadas
/// por qualquer classe responsável por persistência local dos dados,
/// usando o padrão Result para melhor tratamento de erros.
abstract class PokemonLocalStorageRepository {
  /// Salva uma lista de [PokemonModel] localmente.
  ///
  /// Deve sobrescrever qualquer cache anterior.
  /// - [pokemons]: Lista de pokémons a ser armazenada.
  /// - Retorna um [Result<void>] indicando sucesso ou erro.
  Future<Result<void>> savePokemons(List<PokemonModel> pokemons);

  /// Carrega a lista de [PokemonModel] previamente salva localmente.
  ///
  /// - Retorna um [Result<List<PokemonModel>>] com os dados ou erro.
  Future<Result<List<PokemonModel>>> loadPokemons();

  /// Limpa todos os dados de pokémons salvos localmente.
  ///
  /// Útil para cenários como logout, reinicialização de dados ou sincronização forçada.
  /// - Retorna um [Result<void>] indicando sucesso ou erro.
  Future<Result<void>> clearPokemons();
}
