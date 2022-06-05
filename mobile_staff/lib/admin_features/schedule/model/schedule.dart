import 'package:sec_2/admin_features/movie/index.dart';

class Schedule {
  final String? id;
  final String movieId;
  final Movie? movie;
  final int startTime;
  final int endTime;
  final int? capacity;
  final int? seatsLeft;
  final int? price;
  // int get id => _id;

  Schedule(
      {this.id,
      required this.movieId,
      this.movie,
      required this.startTime,
      required this.endTime,
      this.capacity,
      this.seatsLeft,
      this.price}) {
    // _id = id ?? Random.secure().nextInt(1000);
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    // print("object");
    return Schedule(
      id: json['id'],
      movieId: json['movieId'],
      movie: Movie.fromJson(json['movie']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      capacity: json['capacity'],
      seatsLeft: json['seatsLeft'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "movieId": movieId,
        "movie": movie?.toJson(),
        "startTime": startTime,
        "endTime": endTime,
        "capacity": capacity,
        "seatsLeft": seatsLeft,
        "price": price,
      };

}
