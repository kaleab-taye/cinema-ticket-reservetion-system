
import 'package:royal_cinema/features/mobile_customer/home/model/schedule_response.dart';

import '../model/scheduledMovie.dart';

abstract class ScheduledState {}

class ScheduledsLoading extends ScheduledState {}

class ScheduledsLoaded extends ScheduledState {
  List<ScheduleResponse> scheduleds;
  ScheduledsLoaded(this.scheduleds);
}

class ScheduledsLoadingFailed extends ScheduledState {
  final String msg;
  ScheduledsLoadingFailed(this.msg);
}

class ScheduleUpdateSuccessful extends ScheduledState {}
