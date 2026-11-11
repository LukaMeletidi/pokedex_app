import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/services/pokemon_service.dart';

class PokemonNotifier extends AsyncNotifier<List<Pokemon>> {
  final _service = PokemonService();
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  FutureOr<List<Pokemon>> build() async {
    return _service.fetchPokemons();
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    final current = state.value;
    if (current == null) return;
    _isLoadingMore = true;
    try {
      final next = await _service.fetchPokemons(offset: current.length);
      if (next.length < 20) _hasMore = false;
      state = AsyncData([...current, ...next]);
    } catch (_) {
    } finally {
      _isLoadingMore = false;
    }
  }
}

final pokemonProvider = AsyncNotifierProvider<PokemonNotifier, List<Pokemon>>(
  PokemonNotifier.new,
);
