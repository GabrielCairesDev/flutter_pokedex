import 'package:flutter/material.dart';

/// Classe que centraliza todas as cores utilizadas na aplicação.
///
/// Esta classe define constantes de cores para diferentes tipos de Pokémon,
/// além de tons de cinza para uso geral na interface.
///
/// Também fornece um método utilitário para obter uma cor com base no tipo de Pokémon.
///
/// Exemplo de uso:
/// ```dart
/// Color color = AppColors.getColorByPokemonType('fire');
/// ```
class AppColors {
  /// Construtor privado para evitar instanciação da classe.
  AppColors._();

  // Cores da identidade visual e tipos de Pokémon
  static const Color identityPrimary = Color(0xFFDC0A2D);
  static const Color pokemonTypeBug = Color(0xFFA7B723);
  static const Color pokemonTypeDark = Color(0xFF75574C);
  static const Color pokemonTypeDragon = Color(0xFF7037FF);
  static const Color pokemonTypeElectric = Color(0xFFF9CF30);
  static const Color pokemonTypeFairy = Color(0xFFE69EAC);
  static const Color pokemonTypeFighting = Color(0xFFC12239);
  static const Color pokemonTypeFire = Color(0xFFF57D31);
  static const Color pokemonTypeFlying = Color(0xFFA891EC);
  static const Color pokemonTypeGhost = Color(0xFF70559B);
  static const Color pokemonTypeNormal = Color(0xFFAAA67F);
  static const Color pokemonTypeGrass = Color(0xFF74CB48);
  static const Color pokemonTypeGround = Color(0xFFDEC16B);
  static const Color pokemonTypeIce = Color(0xFF9AD6DF);
  static const Color pokemonTypePoison = Color(0xFFA43E9E);
  static const Color pokemonTypePsychic = Color(0xFFFB5584);
  static const Color pokemonTypeRock = Color(0xFFB69E31);
  static const Color pokemonTypeSteel = Color(0xFFB7B9D0);
  static const Color pokemonTypeWater = Color(0xFF6493EB);

  // Tons de cinza
  static const Color grayScaleDark = Color(0xFF212121);
  static const Color grayScaleMedium = Color(0xFF666666);
  static const Color grayScaleLight = Color(0xFFE0E0E0);
  static const Color grayScaleBackground = Color(0xFFEFEFEF);
  static const Color grayScaleWhite = Color(0xFFFFFFFF);

  /// Retorna a cor correspondente a um tipo de Pokémon.
  ///
  /// Caso o tipo informado não corresponda a nenhum tipo conhecido,
  /// retorna a cor primária da identidade visual como fallback.
  ///
  /// Parâmetros:
  /// - [type]: Nome do tipo de Pokémon (case-insensitive).
  ///
  /// Exemplo:
  /// ```dart
  /// Color color = AppColors.getColorByPokemonType('grass');
  /// ```
  static Color getColorByPokemonType(String type) {
    switch (type.toLowerCase()) {
      case 'bug':
        return pokemonTypeBug;
      case 'dark':
        return pokemonTypeDark;
      case 'dragon':
        return pokemonTypeDragon;
      case 'electric':
        return pokemonTypeElectric;
      case 'fairy':
        return pokemonTypeFairy;
      case 'fighting':
        return pokemonTypeFighting;
      case 'fire':
        return pokemonTypeFire;
      case 'flying':
        return pokemonTypeFlying;
      case 'ghost':
        return pokemonTypeGhost;
      case 'normal':
        return pokemonTypeNormal;
      case 'grass':
        return pokemonTypeGrass;
      case 'ground':
        return pokemonTypeGround;
      case 'ice':
        return pokemonTypeIce;
      case 'poison':
        return pokemonTypePoison;
      case 'psychic':
        return pokemonTypePsychic;
      case 'rock':
        return pokemonTypeRock;
      case 'steel':
        return pokemonTypeSteel;
      case 'water':
        return pokemonTypeWater;
      default:
        return identityPrimary;
    }
  }
}
