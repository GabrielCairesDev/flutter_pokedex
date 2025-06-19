import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/pokemon_type_color.dart';

class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final double weight;
  final double height;
  final List<String> moves;
  final int hp;
  final int atk;
  final int def;
  final int satk;
  final int sdef;
  final int spd;
  final String description;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.weight,
    required this.height,
    required this.moves,
    required this.hp,
    required this.atk,
    required this.def,
    required this.satk,
    required this.sdef,
    required this.spd,
    required this.description,
  });

  factory PokemonModel.fromJson(
    Map<String, dynamic> json, {
    List<String>? initialMoves,
    String description = '',
  }) {
    final id = json['id'] ?? 0;
    return PokemonModel(
      id: id,
      name: _capitalize(json['name'] ?? ''),
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      types: (json['types'] != null)
          ? (json['types'] as List)
                .map<String>(
                  (type) => _capitalize(type['type']['name'] as String),
                )
                .toList()
          : <String>[],
      weight: (json['weight'] != null)
          ? (json['weight'] as num).toDouble()
          : 0.0,
      height: (json['height'] != null)
          ? (json['height'] as num).toDouble()
          : 0.0,
      moves: (json['moves'] != null)
          ? (json['moves'] as List)
                .where((move) {
                  return (move['version_group_details'] as List).any((detail) {
                    return detail['move_learn_method']['name'] == 'level-up' &&
                        detail['level_learned_at'] == 1;
                  });
                })
                .map<String>(
                  (move) => _capitalize(move['move']['name'] as String),
                )
                .toSet()
                .toList()
          : <String>[],

      hp: (json['stats'] != null && json['stats'].length > 0)
          ? (json['stats'][0]['base_stat'] ?? 0)
          : 0,
      atk: (json['stats'] != null && json['stats'].length > 1)
          ? (json['stats'][1]['base_stat'] ?? 0)
          : 0,
      def: (json['stats'] != null && json['stats'].length > 2)
          ? (json['stats'][2]['base_stat'] ?? 0)
          : 0,
      satk: (json['stats'] != null && json['stats'].length > 3)
          ? (json['stats'][3]['base_stat'] ?? 0)
          : 0,
      sdef: (json['stats'] != null && json['stats'].length > 4)
          ? (json['stats'][4]['base_stat'] ?? 0)
          : 0,
      spd: (json['stats'] != null && json['stats'].length > 5)
          ? (json['stats'][5]['base_stat'] ?? 0)
          : 0,

      description: description,
    );
  }

  factory PokemonModel.fromCacheJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      types: (json['types'] != null)
          ? List<String>.from(json['types'] as List)
          : <String>[],
      weight: (json['weight'] ?? 0.0).toDouble(),
      height: (json['height'] ?? 0.0).toDouble(),
      moves: (json['moves'] != null)
          ? List<String>.from(json['moves'] as List)
          : <String>[],
      hp: json['hp'] ?? 0,
      atk: json['atk'] ?? 0,
      def: json['def'] ?? 0,
      satk: json['satk'] ?? 0,
      sdef: json['sdef'] ?? 0,
      spd: json['spd'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'weight': weight,
      'height': height,
      'moves': moves,
      'hp': hp,
      'atk': atk,
      'def': def,
      'satk': satk,
      'sdef': sdef,
      'spd': spd,
      'description': description,
    };
  }

  PokemonModel copyWith({String? description}) {
    return PokemonModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types,
      weight: weight,
      height: height,
      moves: moves,
      hp: hp,
      atk: atk,
      def: def,
      satk: satk,
      sdef: sdef,
      spd: spd,
      description: description ?? this.description,
    );
  }

  Color get color {
    if (types.isNotEmpty) {
      return PokemonTypeColor.getColor(types.first);
    }
    return Colors.grey;
  }

  static String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  String get hpString => hp.toString();
  String get atkString => atk.toString();
  String get defString => def.toString();
  String get satkString => satk.toString();
  String get sdefString => sdef.toString();
  String get spdString => spd.toString();
}
