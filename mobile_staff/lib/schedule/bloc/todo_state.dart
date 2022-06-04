import 'package:sec_2/movie/index.dart';
import 'package:sec_2/schedule/model/schedule.dart';
import 'package:sec_2/schedule/model/schedule_response.dart';

abstract class ScheduleState {}

class SchedulesLoading extends ScheduleState {}

class SchedulesLoaded extends ScheduleState {
  List<ScheduleResponse> schedules;
  SchedulesLoaded(this.schedules);
}

class SchedulesLoadingFailed extends ScheduleState {
  final String msg;
  SchedulesLoadingFailed(this.msg);
}

class ScheduleUpdateSuccessful extends ScheduleState {}





class ScheduleCreated extends ScheduleState {
  Schedule schedule;
  ScheduleCreated(this.schedule);
}
class ScheduleCreating extends ScheduleState {}

class ScheduleCreatingFailed extends ScheduleState {
  final String msg;
  ScheduleCreatingFailed(this.msg);
}

class ScheduleCreate extends ScheduleState{}




class ScheduleUpdated extends ScheduleState {
  Schedule schedule;
  ScheduleUpdated(this.schedule);
}
class ScheduleUpdating extends ScheduleState {}

class ScheduleUpdatingFailed extends ScheduleState {
  final String msg;
  ScheduleUpdatingFailed(this.msg);
}

class ScheduleUpdate extends ScheduleState{}



class ScheduleDeleted extends ScheduleState {
  // Schedule schedule;
  // ScheduleUpdated(this.schedule);
}
class ScheduleDeleting extends ScheduleState {}

class ScheduleDeletingFailed extends ScheduleState {
  final String msg;
  ScheduleDeletingFailed(this.msg);
}

class ScheduleDelete extends ScheduleState{}
