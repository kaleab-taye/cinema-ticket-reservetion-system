import 'package:sec_2/admin_features/schedule/data_provider/schedule_provider.dart';
import 'package:sec_2/admin_features/schedule/model/schedule.dart';
import 'package:sec_2/admin_features/schedule/model/schedule_response.dart';

import '../../utils/either.dart';

class ScheduleRepository {
  ScheduleProvider scheduleProvider;
  ScheduleRepository(this.scheduleProvider);

  Future<Either<List<ScheduleResponse>>> getAllSchedules() async {
    
    try {
      final schedules = await scheduleProvider.getAllSchedules();
      return Either(val: schedules);
    } catch (err) {
      return Either(error: "Couldn't load schedules");
    }
  }

  Future<Either<Schedule?>> createSchedule(Schedule schedule) async {
    try {
      final Schedule = await scheduleProvider.addSchedule(schedule);

      return Either(val: Schedule);
    } catch (err) {
      return Either(error: err.toString());
    }
  }

  Future<Either<Schedule>> updateSchedule(Schedule schedule) async {
    try {
      final Schedule = await scheduleProvider.updateSchedule(schedule);
      return Either(val: Schedule);
    } catch (err) {
      return Either(error: "Schedule couldn't be updated");
    }
  }
  
  Future<Either<bool>> deleteSchedule(String id) async {
    try {
      final Schedule = await scheduleProvider.deleteSchedule(id);
      return Either(val: Schedule);
    } catch (err) {
      return Either(error: "Schedule couldn't be Deleted");
    }
  }
}
