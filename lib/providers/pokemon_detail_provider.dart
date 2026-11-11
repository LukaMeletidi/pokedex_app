import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/models/pokemon_detail.dart';
import 'package:pokedex_app/services/pokemon_service.dart';

final pokemonDetailProvider = FutureProvider.family<PokemonDetail, int>((
  ref,
  id,
) {
  return PokemonService().fetchPokemonDetail(id);
});
