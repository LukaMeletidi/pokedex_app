import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(child: Image.network(pokemon.imageUrl)),
            Padding(padding: const EdgeInsets.all(8), child: Text(pokemon.name)),
          ],
        ),
      ),
    );
  }
}
