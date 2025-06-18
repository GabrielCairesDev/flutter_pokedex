import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_config.dart';
import 'package:flutter_pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.I;

void setupDependencies() {
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<PokemonRepository>(() {
    return PokemonRemoteDatasource(client: getIt.get<http.Client>());
  });
}

void main() {
  setupDependencies();
  runApp(const AppConfig());
}
