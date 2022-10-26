class Cast {
  final String name;
  final String? poster;
  final String character;

  Cast({required this.name, required this.poster, required this.character});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
        name: json['name'],
        poster: json['profile_path'],
        character: json['character']);
  }
}
