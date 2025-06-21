import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_config.dart';
import 'package:flutter_pokedex/core/interfaces/http_client_interface.dart';
import 'package:flutter_pokedex/core/interfaces/storage_interface.dart';
import 'package:flutter_pokedex/data/datasources/http_client_impl.dart';
import 'package:flutter_pokedex/data/datasources/pokemon_local_storage_impl.dart';
import 'package:flutter_pokedex/data/datasources/pokemon_repository_impl.dart';
import 'package:flutter_pokedex/data/datasources/storage_impl.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_local_repository.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex/domain/usecases/sync_pokemon_cache_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

/// Instância global do GetIt utilizada para injeção de dependências.
final getIt = GetIt.I;

/// Configura todas as dependências da aplicação utilizando o GetIt.
///
/// Esta função deve ser chamada antes de iniciar o aplicativo, geralmente
/// no `main()`, para garantir que todas as dependências estejam registradas
/// e disponíveis ao longo do ciclo de vida do app.
///
/// As dependências são registradas como `LazySingleton`, ou seja,
/// serão instanciadas apenas na primeira vez que forem requisitadas.
void setupDependencies() {
  /// Registra o cliente HTTP como singleton.
  ///
  /// Utilizado para realizar requisições HTTP em repositórios ou serviços.
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  /// Registra a implementação do cliente HTTP.
  ///
  /// Implementação concreta da interface [HttpClientInterface].
  getIt.registerLazySingleton<HttpClientInterface>(
    () => HttpClientImpl(client: getIt<http.Client>()),
  );

  /// Registra a implementação do storage local.
  ///
  /// Implementação concreta da interface [StorageInterface].
  getIt.registerLazySingleton<StorageInterface>(() => StorageImpl());

  /// Registra a implementação local do repositório de Pokémon.
  ///
  /// Responsável por persistência local (cache) dos dados.
  getIt.registerFactory<PokemonLocalStorageRepository>(
    () => PokemonLocalStorageImpl(storage: getIt<StorageInterface>()),
  );

  /// Registra a implementação remota do repositório de Pokémon.
  ///
  /// Utiliza o cliente HTTP injetado para consumir APIs.
  getIt.registerFactory<PokemonRepository>(
    () => PokemonRepositoryImpl(client: getIt<HttpClientInterface>()),
  );

  /// Registra o caso de uso de sincronização do cache de Pokémon.
  ///
  /// Depende tanto do repositório remoto quanto do local para funcionar.
  getIt.registerFactory<SyncPokemonCacheUseCase>(
    () => SyncPokemonCacheUseCase(
      pokemonRepository: getIt(),
      localRepository: getIt(),
    ),
  );
}

/// Função principal do aplicativo Flutter.
///
/// Inicializa as dependências com `setupDependencies()` e,
/// em seguida, executa o aplicativo com o widget [AppConfig].
void main() {
  setupDependencies();
  runApp(const AppConfig());
}
