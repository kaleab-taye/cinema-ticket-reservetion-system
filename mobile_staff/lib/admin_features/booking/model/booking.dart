import 'package:sec_2/admin_features/schedule/model/schedule.dart';
import 'package:sec_2/admin_features/user/models/user.dart';

class Booking {
  final String? id;
  final String userId;
  final String? scheduleId;
  final Schedule? schedule;
  final User? user;

  Booking({
    this.id,
    required this.userId,
    this.scheduleId,
    this.schedule,
    this.user
  }) {}

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        id: json['id'],
        userId: json['userId'],
        scheduleId: json['scheduleId'],
        schedule: Schedule.fromJson(json['schedule']),
        user: User.fromJson(json['user'])
        );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "scheduleId": scheduleId,
        "schedule": schedule!.toJson(),
        "user": user!.toJson()

      };
}
