import 'package:sec_2/movie/index.dart';
import 'package:sec_2/schedule/model/schedule.dart';

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
