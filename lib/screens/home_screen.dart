import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/providers/pokemon_provider.dart';
import 'package:pokedex_app/widgets/pokemon_card.dart';

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
        data: (pokemons) => NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200) {
              ref.read(pokemonProvider.notifier).loadMore();
            }
            return false;
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
            ),
            itemCount: pokemons.length,
            itemBuilder: (ctx, index) {
              return PokemonCard(pokemon: pokemons[index]);
            },
          ),
        ),
      ),
    );
  }
}
