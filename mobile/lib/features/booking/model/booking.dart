import 'dart:math';

import 'package:royal_cinema/features/home/model/movie.dart';
import 'package:royal_cinema/features/home/model/scheduledMovie.dart';

import '../../user/model/user.dart';

class BookingMovie {
  late String _id;
  final String userId;
  final String scheduleId;
  final ScheduledMovie schedule;
  final User user;

  String get id => _id;

  BookingMovie(
      {required this.userId,
        required this.scheduleId,
        required this.schedule,
        required this.user,
        String? id}) {
    _id = (id ?? Random.secure().nextInt(1000)).toString();
  }

  factory BookingMovie.fromJson(Map<String, dynamic> json) => BookingMovie(
    id: json['id'],
    userId: json['userId'],
    scheduleId: json['scheduleId'],
    schedule: ScheduledMovie.fromJson(json['schedule']),
    user: User.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'scheduleId': scheduleId,
    'schedule': schedule,
    'user': user,
  };

}
