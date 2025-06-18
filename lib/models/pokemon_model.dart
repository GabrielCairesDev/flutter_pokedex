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
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
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
          ? List<String>.from(
              (json['moves'] as List).map(
                (move) => move['move']['name'] as String,
              ),
            )
          : <String>[],
      hp: json['stats'] != null ? (json['stats'][0]['base_stat'] ?? 0) : 0,
      atk: json['stats'] != null ? (json['stats'][1]['base_stat'] ?? 0) : 0,
      def: json['stats'] != null ? (json['stats'][2]['base_stat'] ?? 0) : 0,
      satk: json['stats'] != null ? (json['stats'][3]['base_stat'] ?? 0) : 0,
      sdef: json['stats'] != null ? (json['stats'][4]['base_stat'] ?? 0) : 0,
      spd: json['stats'] != null ? (json['stats'][5]['base_stat'] ?? 0) : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'tipos': types,
      'weight': weight,
      'height': height,
      'moves': moves,
      'hp': hp,
      'atk': atk,
      'def': def,
      'satk': satk,
      'sdef': sdef,
      'spd': spd,
    };
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
}
