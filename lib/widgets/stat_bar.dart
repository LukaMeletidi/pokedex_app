import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_detail.dart';

class StatBar extends StatelessWidget {
  const StatBar({super.key, required this.stat});

  final PokemonStat stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(stat.name)),
          SizedBox(width: 40, child: Text('${stat.value}')),
          Expanded(
            child: LinearProgressIndicator(
              value: stat.value / 255,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
