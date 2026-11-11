import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/providers/pokemon_detail_provider.dart';
import 'package:pokedex_app/widgets/stat_bar.dart';

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
        data: (detail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(detail.imageUrl, height: 250),
              const SizedBox(height: 16),
              Text('#${detail.id}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: detail.types
                    .map((type) => Chip(label: Text(type)))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('${detail.heightInMeters} m'),
                      const Text('Height'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('${detail.weightInKg} kg'),
                      const Text('Weight'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Base stats',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...detail.stats.map((stat) => StatBar(stat: stat)),
            ],
          ),
        ),
      ),
    );
  }
}
