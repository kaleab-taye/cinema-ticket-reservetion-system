
import 'package:royal_cinema/features/home/index.dart';
import 'package:royal_cinema/features/home/model/schedule_response.dart';

import '../model/scheduledMovie.dart';
import 'schedule_provider.dart';

class ScheduledLocalProvider implements ScheduledProvider {

  final List<ScheduleResponse> schedules = [
    for (int i in List.generate(15, (i) => i))
      ScheduleResponse(date: "Today", schedules: [])
  ];

  final List<ScheduledMovie> scheduleds = [
    for (int i in List.generate(15, (i) => i))
      ScheduledMovie(
          movieId: "movieId",
          movie: Movie(title: "title", description: "description", imageUrl: "imageUrl", casts:[], genera: []),
          startTime: 123,
          endTime: 520,
          capacity: 20,
          seatsLeft: 12,
          price: 200
      )
  ];

  @override
  addScheduled(ScheduledMovie scheduled) async {
    return scheduleds.add(scheduled);
  }

  @override
  editScheduled(String id, ScheduledMovie scheduled) async {
    int index = -1;
    for (int i = 0; i < scheduleds.length; i++) {
      if (scheduleds[i].id == id) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      throw Exception("Scheduled Movie not found");
    }

    scheduleds[index] = ScheduledMovie(
        movieId: scheduled.movieId,
        movie: scheduled.movie,
        startTime: scheduled.startTime,
        endTime: scheduled.endTime,
        capacity: scheduled.capacity,
        seatsLeft: scheduled.seatsLeft,
        price: scheduled.price);
  }

  @override
  Future<ScheduledMovie> getScheduled(String id) async {
    for (int i = 0; i < scheduleds.length; i++) {
      if (scheduleds[i].id == id) {
        return scheduleds[i];
      }
    }

    throw Exception('Scheduled Movie not found');
  }

  @override
  Future<List<ScheduleResponse>> getAllScheduleds() async {
    return schedules;
  }
}
