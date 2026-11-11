class Pokemon {
  const Pokemon({required this.id, required this.name, required this.imageUrl});

  final int id;
  final String name;
  final String imageUrl;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final url = json['url'] as String;

    final parts = url.split('/');
    final id = int.parse(parts[parts.length - 2]);

    return Pokemon(
      id: id,
      name: name,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}
