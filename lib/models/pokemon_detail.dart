class PokemonStat {
  const PokemonStat({required this.name, required this.value});

  final String name;
  final int value;

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    final statInfo = json['stat'] as Map<String, dynamic>;
    return PokemonStat(
      name: statInfo['name'] as String,
      value: json['base_stat'] as int,
    );
  }
}

class PokemonDetail {
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
  });

  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final List<PokemonStat> stats;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final typesList = json['types'] as List;
    final types = typesList.map((item) {
      final typeInfo = item['type'] as Map<String, dynamic>;
      return typeInfo['name'] as String;
    }).toList();
    final statsList = json['stats'] as List;
    final stats = statsList
        .map((item) => PokemonStat.fromJson(item as Map<String, dynamic>))
        .toList();
    return PokemonDetail(
      id: id,
      name: json['name'] as String,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: types,
      stats: stats,
    );
  }
}
