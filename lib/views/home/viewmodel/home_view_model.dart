import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  int qunatityPokemons = 0;

  Future<void> init() async {
    await getQuantityPokemons();
  }

  Future<void> getQuantityPokemons() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon-species/?limit=0');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        qunatityPokemons = data['count'];
      } else {
        debugPrint('Falha na requisição. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
    }
  }
}
