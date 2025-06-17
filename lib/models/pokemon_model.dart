class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> tipos;
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
    required this.tipos,
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
    return PokemonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      tipos: (json['tipos'] != null)
          ? List<String>.from(json['tipos'])
          : <String>[],
      weight: (json['weight'] != null)
          ? (json['weight'] as num).toDouble()
          : 0.0,
      height: (json['height'] != null)
          ? (json['height'] as num).toDouble()
          : 0.0,
      moves: (json['moves'] != null)
          ? List<String>.from(json['moves'])
          : <String>[],
      hp: json['hp'] ?? 0,
      atk: json['atk'] ?? 0,
      def: json['def'] ?? 0,
      satk: json['satk'] ?? 0,
      sdef: json['sdef'] ?? 0,
      spd: json['spd'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'tipos': tipos,
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
}
