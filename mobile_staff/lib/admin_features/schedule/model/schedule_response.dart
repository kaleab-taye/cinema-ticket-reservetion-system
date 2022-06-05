import 'package:sec_2/admin_features/schedule/model/schedule.dart';

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
