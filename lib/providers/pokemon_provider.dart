import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/services/pokemon_service.dart';

class LoadingMoreNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setLoading(bool value) {
    state = value;
  }
}

class PokemonNotifier extends AsyncNotifier<List<Pokemon>> {
  final _service = PokemonService();
  bool _hasMore = true;

  @override
  FutureOr<List<Pokemon>> build() async {
    return _service.fetchPokemons();
  }

  Future<void> loadMore() async {
    if (ref.read(loadingMoreProvider) || !_hasMore) return;
    final current = state.value;
    if (current == null) return;
    ref.read(loadingMoreProvider.notifier).setLoading(true);
    try {
      final next = await _service.fetchPokemons(offset: current.length);
      if (next.length < 20) _hasMore = false;
      state = AsyncData([...current, ...next]);
    } catch (_) {
    } finally {
      ref.read(loadingMoreProvider.notifier).setLoading(false);
    }
  }
}

final pokemonProvider = AsyncNotifierProvider<PokemonNotifier, List<Pokemon>>(
  PokemonNotifier.new,
);

final loadingMoreProvider = NotifierProvider<LoadingMoreNotifier, bool>(
  LoadingMoreNotifier.new,
);
