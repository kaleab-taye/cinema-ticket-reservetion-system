
import '../model/scheduledMovie.dart';

abstract class ScheduledState {}

class ScheduledsLoading extends ScheduledState {}

class ScheduledsLoaded extends ScheduledState {
  List<ScheduledMovie> scheduleds;
  ScheduledsLoaded(this.scheduleds);
}

class ScheduledsLoadingFailed extends ScheduledState {
  final String msg;
  ScheduledsLoadingFailed(this.msg);
}

class ScheduleUpdateSuccessful extends ScheduledState {}
