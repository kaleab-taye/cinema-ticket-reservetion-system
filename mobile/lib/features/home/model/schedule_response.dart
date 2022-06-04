import 'package:royal_cinema/features/home/model/scheduledMovie.dart';

class ScheduleResponse {
  // final String? id;
  final String date;
  final List<ScheduledMovie> schedules;
  ScheduleResponse(
      {
        required this.date,
        required this.schedules,
      }){

  }
  }