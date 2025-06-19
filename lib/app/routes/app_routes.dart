import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/pokemon/view/pokemon_view.dart';
import 'package:flutter_pokedex/presentation/home/view/home_view.dart';

/// Classe responsável por definir e centralizar as rotas de navegação da aplicação.
///
/// Esta classe contém as rotas nomeadas usadas no [MaterialApp],
/// facilitando o gerenciamento e evitando erros de digitação nos nomes das rotas.
///
/// Exemplo de uso:
/// ```dart
/// Navigator.pushNamed(context, AppRoutes.pokemon);
/// ```
class AppRoutes {
  /// Construtor privado para evitar instanciação.
  AppRoutes._();

  /// Nome da rota da tela inicial (Home).
  static const String home = '/home';

  /// Nome da rota da tela de detalhes de um Pokémon.
  static const String pokemon = '/pokemon';

  /// Mapa de rotas da aplicação.
  ///
  /// Este mapa é utilizado pelo [MaterialApp] para fazer o mapeamento
  /// de cada string de rota para o widget correspondente.
  ///
  /// Exemplo de configuração no `MaterialApp`:
  /// ```dart
  /// MaterialApp(
  ///   initialRoute: AppRoutes.home,
  ///   routes: AppRoutes.routes,
  /// )
  /// ```
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => HomeView(),
    pokemon: (context) => const PokemonView(),
  };
}
