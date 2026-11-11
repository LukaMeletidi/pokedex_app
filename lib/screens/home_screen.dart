import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/providers/pokemon_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonsAsync = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: pokemonsAsync.when(
        error: (error, stack) => Center(child: Text('Error $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (pokemons) => ListView.builder(
          itemCount: pokemons.length,
          itemBuilder: (ctx, index) {
            final pokemon = pokemons[index];
            return ListTile(
              leading: Image.network(pokemon.imageUrl, width: 56, height: 56),
              title: Text(pokemon.name),
            );
          },
        ),
      ),
    );
  }
}
