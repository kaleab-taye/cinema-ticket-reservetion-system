import 'dart:math';

import 'package:royal_cinema/features/mobile_customer/home/model/movie.dart';

class ScheduledMovie {
  String? id;
  final String movieId;
  final Movie movie;
  final int startTime;
  final int endTime;
  final int capacity;
  final int seatsLeft;
  final int price;

  // String get id => _id;

  ScheduledMovie(
      {
        this.id,
        required this.movieId,
        required this.movie,
        required this.startTime,
        required this.endTime,
        required this.capacity,
        required this.seatsLeft,
        required this.price,});
  // {
  //   _id = (id ?? Random.secure().nextInt(1000)).toString();
  // }

  factory ScheduledMovie.fromJson(Map<String, dynamic> json) => ScheduledMovie(
    id: json['id'],
    movieId: json['movieId'],
    movie: Movie.fromJson(json['movie']),
    startTime: json['startTime'],
    endTime: json['endTime'],
    capacity: json['capacity'],
    seatsLeft: json['seatsLeft'],
    price: json['price'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'movieId': movieId,
    'movie': movie,
    'startTime': startTime,
    'endTime': endTime,
    'capacity': capacity,
    'seatsLeft': seatsLeft,
    'price': price,
  };

}
