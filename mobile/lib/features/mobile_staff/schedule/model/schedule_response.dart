import 'package:royal_cinema/features/mobile_staff/schedule/model/schedule.dart';

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
