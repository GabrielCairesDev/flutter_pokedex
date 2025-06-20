import 'package:flutter_pokedex/domain/repositories/pokemon_local_repository.dart';
import '../../data/models/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso responsável por sincronizar o cache local de Pokémons.
///
/// Compara a quantidade de Pokémons disponíveis online com os dados já salvos localmente.
/// Se o cache estiver incompleto, busca todos os Pokémons da API e atualiza o armazenamento local.
/// Caso contrário, retorna os dados já armazenados.
class SyncPokemonCacheUseCase {
  /// Repositório remoto utilizado para obter dados atualizados dos Pokémons.
  final PokemonRepository pokemonRepository;

  /// Repositório local utilizado para armazenar e recuperar Pokémons do cache.
  final PokemonLocalStorageRepository localRepository;

  /// Cria uma instância de [SyncPokemonCacheUseCase].
  ///
  /// - [pokemonRepository]: Fonte dos dados da API.
  /// - [localRepository]: Fonte e destino do cache local.
  SyncPokemonCacheUseCase({
    required this.pokemonRepository,
    required this.localRepository,
  });

  /// Executa a sincronização do cache local com os dados da API.
  ///
  /// Retorna uma lista de [PokemonModel] que representa os dados atualizados.
  /// - Se o cache estiver incompleto, a função busca todos os Pokémons online e atualiza o local.
  /// - Se o cache estiver completo, retorna diretamente os dados já armazenados.
  Future<List<PokemonModel>> call() async {
    final totalOnline = await pokemonRepository.fetchPokemonCount();
    final cachedPokemons = await localRepository.loadPokemons();

    if (cachedPokemons.length < totalOnline) {
      final fetched = await pokemonRepository.fetchAllPokemons(totalOnline);
      await localRepository.savePokemons(fetched);
      return fetched;
    } else {
      return cachedPokemons;
    }
  }
}
