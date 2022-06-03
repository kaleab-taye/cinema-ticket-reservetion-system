
import 'package:royal_cinema/features/home/model/schedule_response.dart';

import '../model/scheduledMovie.dart';

abstract class ScheduledProvider {
  Future<void> addScheduled(ScheduledMovie scheduled);
  Future<void> editScheduled(String id, ScheduledMovie scheduled);
  Future<ScheduledMovie?> getScheduled(String id);
  Future<List<ScheduleResponse>> getAllScheduleds();
}
