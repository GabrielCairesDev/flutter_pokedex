import 'package:flutter_pokedex/core/result/result.dart';
import 'package:flutter_pokedex/core/exceptions/pokemon_exceptions.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_local_repository.dart';
import '../../data/models/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso responsável por sincronizar o cache local de Pokémons.
///
/// Compara a quantidade de Pokémons disponíveis online com os dados já salvos localmente.
/// Se o cache estiver incompleto, busca todos os Pokémons da API e atualiza o armazenamento local.
/// Caso contrário, retorna os dados já armazenados.
/// Usa o padrão Result para melhor tratamento de erros.
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
  /// Retorna um [Result<List<PokemonModel>>] que representa os dados atualizados ou erro.
  /// - Se o cache estiver incompleto, a função busca todos os Pokémons online e atualiza o local.
  /// - Se o cache estiver completo, retorna diretamente os dados já armazenados.
  Future<Result<List<PokemonModel>>> call() async {
    try {
      // Busca a quantidade total de Pokémons online
      final countResult = await pokemonRepository.fetchPokemonCount();

      return await countResult.when(
        success: (totalOnline) async {
          // Carrega os dados do cache local
          final cacheResult = await localRepository.loadPokemons();

          return await cacheResult.when(
            success: (cachedPokemons) async {
              // Verifica se o cache está completo
              if (cachedPokemons.length < totalOnline) {
                // Cache incompleto, busca todos os Pokémons online
                final fetchResult = await pokemonRepository.fetchAllPokemons(
                  totalOnline,
                );

                return await fetchResult.when(
                  success: (fetchedPokemons) async {
                    // Salva os novos dados no cache
                    final saveResult = await localRepository.savePokemons(
                      fetchedPokemons,
                    );

                    return saveResult.when(
                      success: (_) => Result.success(fetchedPokemons),
                      failure: (error) => Result.failure(error),
                    );
                  },
                  failure: (error) => Result.failure(error),
                );
              } else {
                // Cache completo, retorna os dados locais
                return Result.success(cachedPokemons);
              }
            },
            failure: (error) => Result.failure(error),
          );
        },
        failure: (error) => Result.failure(error),
      );
    } catch (e) {
      return Result.failure(
        NetworkException(
          'Erro inesperado durante sincronização do cache: $e',
          errorCode: 'SYNC_UNKNOWN_ERROR',
          details: {'originalError': e.toString()},
        ),
      );
    }
  }
}
