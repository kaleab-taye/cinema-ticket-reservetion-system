import 'package:royal_cinema/features/mobile_staff/movie/index.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/model/schedule.dart';

abstract class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {}

class CreateSchedule extends ScheduleEvent {
  final Schedule schedule;
  CreateSchedule(this.schedule);
}

class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;
  UpdateSchedule(this.schedule);
}

class DeleteSchedule extends ScheduleEvent {
  final String id;
  DeleteSchedule(this.id);
}

class UpdateMovie extends ScheduleEvent {
  final Movie movie;
  UpdateMovie(this.movie);
}
