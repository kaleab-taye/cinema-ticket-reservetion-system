
import 'package:royal_cinema/core/utils/either.dart';
import 'package:royal_cinema/features/home/model/schedule_response.dart';
import 'package:royal_cinema/features/home/model/scheduledMovie.dart';

import '../data_provider/schedule_provider.dart';

class ScheduledRepository {
  ScheduledProvider scheduledProvider;
  ScheduledRepository(this.scheduledProvider);

  // Future<List<ScheduledMovie>> getScheduledsWithTitle(String id) async {
  //   final scheduleds = await scheduledProvider.getAllScheduleds();
  //   return scheduleds.where((scheduled) => scheduled.id == id).toList();
  // }

  Future<Either<List<ScheduleResponse>>> getAllScheduleds() async {
    try {
      final scheduleds = await scheduledProvider.getAllScheduleds();
      return Either(val: scheduleds);
    } catch (err) {
      print(err);
      return Either(error: "Couldn't load schedules");
    }
  }

  Future<Either<ScheduledMovie>> getScheduled(String id) async {
    try {
      final scheduled = await scheduledProvider.getScheduled(id);
      return Either(val: scheduled);
    } catch (err) {
      return Either(error: "Schedules not found");
    }
  }

  addScheduled(ScheduledMovie scheduled) async {
    // check for profanity
    // scheduled.description.contains("sidib");
    final newScheduled = ScheduledMovie(
        movieId: scheduled.movieId,
        movie: scheduled.movie,
        startTime: scheduled.startTime,
        endTime: scheduled.endTime,
        capacity: scheduled.capacity,
        seatsLeft: scheduled.seatsLeft,
        price: scheduled.price
    );

    await scheduledProvider.addScheduled(newScheduled);
  }

  Future<Either<String>> editScheduled(String id, ScheduledMovie scheduled) async {
    try {
      final newScheduled = ScheduledMovie(
          movieId: scheduled.movieId,
          movie: scheduled.movie,
          startTime: scheduled.startTime,
          endTime: scheduled.endTime,
          capacity: scheduled.capacity,
          seatsLeft: scheduled.seatsLeft,
          price: scheduled.price
      );

      await scheduledProvider.editScheduled(id, newScheduled);
      return Either(val: "");
    } catch (err) {
      return Either(error: "Schedules not found");
    }
  }
}
