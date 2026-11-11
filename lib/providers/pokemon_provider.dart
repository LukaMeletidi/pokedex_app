import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/services/pokemon_service.dart';

class PokemonNotifier extends AsyncNotifier<List<Pokemon>> {
  final _service = PokemonService();

  @override
  FutureOr<List<Pokemon>> build() async {
    return _service.fetchPokemons();
  }
}

final pokemonProvider = AsyncNotifierProvider<PokemonNotifier, List<Pokemon>>(
  PokemonNotifier.new,
);
