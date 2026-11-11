import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pokedex_app/models/pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemons({int limit = 20, int offset = 0}) async {
    final uri = Uri.parse(
      'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load pokemons');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List;
    return results
        .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
