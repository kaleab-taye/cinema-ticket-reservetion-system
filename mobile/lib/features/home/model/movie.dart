import 'dart:math';

class Movie {
  late String _id;
  final String title;
  final String description;
  final String imageUrl;
  final List<dynamic> casts;
  final List<dynamic> genera;

  String get id => _id;

  Movie(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.casts,
      required this.genera,
      String? id}) {
    _id = (id ?? Random.secure().nextInt(1000)).toString();
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    casts: json['casts'],
    genera: json['genera'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'casts': casts,
    'genera': genera,
  };

}
