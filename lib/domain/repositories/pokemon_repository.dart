import '../../data/models/pokemon_model.dart';
import '../../core/result/result.dart';

/// Contrato para o repositório remoto de Pokémon.
///
/// Define as operações de obtenção de dados da API, como contagem,
/// listagem e descrição dos Pokémons, usando o padrão Result para
/// melhor tratamento de erros.
abstract class PokemonRepository {
  /// Obtém o número total de Pokémons disponíveis na API.
  ///
  /// Retorna um [Result<int>] representando a quantidade total ou erro.
  Future<Result<int>> fetchPokemonCount();

  /// Busca uma lista com os primeiros [quantity] Pokémons disponíveis.
  ///
  /// A ordem pode variar conforme a implementação da API.
  ///
  /// - [quantity]: Número máximo de Pokémons a buscar.
  /// - Retorna um [Result<List<PokemonModel>>] com os Pokémons ou erro.
  Future<Result<List<PokemonModel>>> fetchAllPokemons(int quantity);

  /// Busca os dados de um Pokémon específico a partir de seu [id].
  ///
  /// - [id]: Identificador único do Pokémon (geralmente o número na Pokédex).
  /// - Retorna um [Result<PokemonModel?>] com o Pokémon ou erro.
  Future<Result<PokemonModel?>> fetchPokemonById(int id);

  /// Obtém a descrição (flavor text) de um Pokémon específico.
  ///
  /// - [id]: Identificador do Pokémon.
  /// - Retorna um [Result<String>] com a descrição ou erro.
  Future<Result<String>> fetchPokemonDescription(int id);
}
