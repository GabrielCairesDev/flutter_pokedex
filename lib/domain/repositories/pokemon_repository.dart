import '../../data/models/pokemon_model.dart';

/// Abstração do repositório de dados de Pokémon.
///
/// Define os contratos que qualquer implementação de repositório (local, remoto ou híbrido)
/// deve seguir para fornecer os dados necessários ao aplicativo.
///
/// Permite isolar a lógica de obtenção de dados da camada de apresentação,
/// facilitando a implementação de testes, manutenção e troca de fontes de dados.
///
/// Exemplo de possíveis implementações:
/// - [PokemonRepositoryImpl] com API e cache.
/// - Um mock para testes unitários.
abstract class PokemonRepository {
  /// Busca o número total de espécies de Pokémon disponíveis.
  ///
  /// Este valor geralmente é utilizado para calcular o número máximo de registros
  /// que podem ser paginados ou carregados.
  ///
  /// Retorna:
  /// - Um inteiro representando a quantidade total de Pokémons disponíveis.
  Future<int> fetchPokemonCount();

  /// Busca uma lista de Pokémons com base em uma quantidade específica.
  ///
  /// Parâmetros:
  /// - [quantity]: Quantidade de Pokémons a serem buscados.
  ///
  /// Retorna:
  /// - Uma lista de [PokemonModel] com as informações básicas dos Pokémons.
  Future<List<PokemonModel>> fetchAllPokemons(int quantity);

  /// Busca os detalhes completos de um Pokémon específico pelo seu ID.
  ///
  /// Parâmetros:
  /// - [id]: ID numérico do Pokémon.
  ///
  /// Retorna:
  /// - Um [PokemonModel] com os detalhes completos, ou `null` caso não encontrado.
  Future<PokemonModel?> fetchPokemonById(int id);

  /// Busca a descrição em texto de uma espécie de Pokémon.
  ///
  /// Parâmetros:
  /// - [id]: ID numérico da espécie de Pokémon.
  ///
  /// Retorna:
  /// - Uma [String] contendo a descrição (exemplo: flavor text ou lore).
  Future<String> fetchPokemonDescription(int id);
}
