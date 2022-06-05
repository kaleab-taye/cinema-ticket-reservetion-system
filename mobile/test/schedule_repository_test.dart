
import 'package:royal_cinema/core/utils/either.dart';
import 'package:royal_cinema/features/home/data_provider/schedule_remote_provider.dart';
import 'package:royal_cinema/features/home/model/schedule_response.dart';
import 'package:royal_cinema/features/home/repository/schedule_repository.dart';
import 'package:test/test.dart';

void main() {
  test('getAllScheduleds shall return a value with .hasError false: ',
      () async {
    ScheduledRemoteProvider scheduledRemoteProvider = ScheduledRemoteProvider();
    ScheduledRepository scheduledRepository =
        ScheduledRepository(scheduledRemoteProvider);

    Either<List<ScheduleResponse>> allSchedules =
        await scheduledRepository.getAllScheduleds();

    expect(allSchedules.hasError, false);
  });
}
