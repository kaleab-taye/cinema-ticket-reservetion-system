import 'package:sec_2/movie/index.dart';
import 'package:sec_2/schedule/model/schedule.dart';
import 'package:sec_2/schedule/model/schedule_response.dart';

abstract class ScheduleProvider {
  Future<Schedule> addSchedule(Schedule schedule);
  Future<Schedule> updateSchedule(Schedule schedule);
  Future<bool> deleteSchedule(String id);
  // Future<void> editMovie(int id, Movie movie);
  // Future<Movie> getMovie(int id);
  Future<List<ScheduleResponse>> getAllSchedules();

}
