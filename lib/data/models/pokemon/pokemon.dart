class Pokemon {
  final String name;
  final String spriteUrl;
  final int weight;
  final int height;
  final List<String> types;

  Pokemon({required this.name, required this.spriteUrl, required this.weight, required this.height, required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      spriteUrl: json['spriteUrl'],
      weight: json['weight'],
      height: json['height'],
      types: (json['types'] as List)
          .map((t) => t['type']['name'].toString())
          .toList(),
    );
  }
}