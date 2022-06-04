import 'package:sec_2/movie/model/movie.dart';
import 'package:sec_2/schedule/model/schedule.dart';

class ScheduleResponse {
  final String date;
  final List<Schedule> schedules;
  ScheduleResponse(
      {
      required this.date,
      required this.schedules,
      }) {
  }
}
