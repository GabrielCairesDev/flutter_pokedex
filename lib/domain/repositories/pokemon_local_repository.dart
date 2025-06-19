import 'package:flutter_pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';

/// Repositório local responsável por intermediar o acesso ao cache de Pokémons.
///
/// Esta classe encapsula a lógica de persistência local de dados,
/// delegando as operações ao [PokemonLocalDatasource].
///
/// É uma camada extra entre o datasource e a aplicação,
/// permitindo desacoplar ainda mais o código e facilitar futuras extensões.
///
/// Exemplo de uso:
/// ```dart
/// await localRepository.savePokemons(listaDePokemons);
/// List<PokemonModel> pokemons = await localRepository.getAllPokemons();
/// await localRepository.clearCache();
/// ```
class PokemonLocalRepository {
  /// Instância interna do datasource local de Pokémons.
  final PokemonLocalDatasource datasource = PokemonLocalDatasource();

  /// Salva uma lista de Pokémons no cache local.
  ///
  /// Parâmetros:
  /// - [pokemons]: Lista de instâncias de [PokemonModel] a serem armazenadas.
  ///
  /// Exemplo:
  /// ```dart
  /// await localRepository.savePokemons(listaDePokemons);
  /// ```
  Future<void> savePokemons(List<PokemonModel> pokemons) async {
    await datasource.cachePokemons(pokemons);
  }

  /// Recupera todos os Pokémons armazenados no cache local.
  ///
  /// Retorna:
  /// - Uma lista de [PokemonModel] com os dados armazenados.
  ///
  /// Exemplo:
  /// ```dart
  /// List<PokemonModel> pokemons = await localRepository.getAllPokemons();
  /// ```
  Future<List<PokemonModel>> getAllPokemons() async {
    return await datasource.fetchAllPokemons();
  }

  /// Limpa o cache local, removendo todos os Pokémons armazenados.
  ///
  /// Exemplo:
  /// ```dart
  /// await localRepository.clearCache();
  /// ```
  Future<void> clearCache() async {
    await datasource.clearPokemons();
  }
}
