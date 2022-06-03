import 'dart:math';

import 'package:royal_cinema/features/home/model/movie.dart';

class ScheduledMovie {
  late String _id;
  final String movieId;
  final Movie movie;
  final int startingTime;
  final int endTime;
  final int capacity;
  final int seatsLeft;
  final int price;

  String get id => _id;

  ScheduledMovie(
      {required this.movieId,
        required this.movie,
        required this.startingTime,
        required this.endTime,
        required this.capacity,
        required this.seatsLeft,
        required this.price,
        String? id}) {
    _id = (id ?? Random.secure().nextInt(1000)).toString();
  }

  factory ScheduledMovie.fromJson(Map<String, dynamic> json) => ScheduledMovie(
    id: json['id'],
    movieId: json['movieId'],
    movie: json['movie'],
    startingTime: json['startingTime'],
    endTime: json['endTime'],
    capacity: json['capacity'],
    seatsLeft: json['seatsLeft'],
    price: json['price'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'movieId': movieId,
    'movie': movie,
    'startingTime': startingTime,
    'endTime': endTime,
    'capacity': capacity,
    'seatsLeft': seatsLeft,
    'price': price,
  };

}
