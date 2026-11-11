import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/providers/pokemon_detail_provider.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(pokemonDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: detailAsync.when(
        error: (error, stack) => Center(child: Text('Error $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (detail) => Center(child: Text(detail.types.join(', '))),
      ),
    );
  }
}
