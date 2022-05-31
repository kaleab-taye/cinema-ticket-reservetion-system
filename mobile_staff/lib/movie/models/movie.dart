import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Movie extends Equatable {
  Movie(
      {this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.casts,
      this.genera});

  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final List<dynamic> casts;
  final List<dynamic> genera;

  @override
  List<Object> get props => [id, title, imageUrl, description, casts, genera];

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      casts: json['casts'],
      genera: json['genera'],
    );
  }

  @override
  String toString() => 'Movie { id: $id, imageUrl: $imageUrl, casts: $casts }';
}
