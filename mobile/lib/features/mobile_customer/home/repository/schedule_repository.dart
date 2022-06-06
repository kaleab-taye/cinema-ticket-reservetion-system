
import 'package:royal_cinema/core/customer_core/utils/either.dart';
import 'package:royal_cinema/features/mobile_customer/home/model/schedule_response.dart';
import 'package:royal_cinema/features/mobile_customer/home/model/scheduledMovie.dart';

import '../data_provider/schedule_provider.dart';

class ScheduledRepository {
  ScheduledProvider scheduledProvider;
  ScheduledRepository(this.scheduledProvider);

  Future<Either<List<ScheduleResponse>>> getAllScheduleds() async {
    try {
      final scheduleds = await scheduledProvider.getAllScheduleds();
      return Either(val: scheduleds);
    } catch (err) {
      print(err);
      return Either(error: "Couldn't load schedules");
    }
  }
}
