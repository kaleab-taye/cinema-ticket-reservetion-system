// ignore_for_file: prefer_const_constructors

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String casts;
  final String genera;
  const Movie({
   required this.id,
   required this.title,
   required this.description,
   required this.imageUrl,
   required this.casts,
   required this.genera,
});

  @override
  List<Object?> get props => [id, title, description, imageUrl, casts, genera];

  static List<Movie> movies = [
    Movie(id: "id", title: "title", description: "description", imageUrl: 'images/60578.jpg', casts: "casts", genera: "genera"),
  ];
}