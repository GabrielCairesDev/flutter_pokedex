import '../../data/models/pokemon_model.dart';

/// Contrato para o repositório remoto de Pokémon.
///
/// Define as operações de obtenção de dados da API, como contagem,
/// listagem e descrição dos Pokémons.
abstract class PokemonRepository {
  /// Obtém o número total de Pokémons disponíveis na API.
  ///
  /// Retorna um inteiro representando a quantidade total.
  Future<int> fetchPokemonCount();

  /// Busca uma lista com os primeiros [quantity] Pokémons disponíveis.
  ///
  /// A ordem pode variar conforme a implementação da API.
  ///
  /// - [quantity]: Número máximo de Pokémons a buscar.
  /// - Retorna uma lista com até [quantity] objetos [PokemonModel].
  Future<List<PokemonModel>> fetchAllPokemons(int quantity);

  /// Busca os dados de um Pokémon específico a partir de seu [id].
  ///
  /// - [id]: Identificador único do Pokémon (geralmente o número na Pokédex).
  /// - Retorna um [PokemonModel], ou `null` se não encontrado.
  Future<PokemonModel?> fetchPokemonById(int id);

  /// Obtém a descrição (flavor text) de um Pokémon específico.
  ///
  /// - [id]: Identificador do Pokémon.
  /// - Retorna uma `String` contendo a descrição.
  Future<String> fetchPokemonDescription(int id);
}
