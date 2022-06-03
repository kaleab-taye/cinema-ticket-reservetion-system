
import '../model/scheduledMovie.dart';

abstract class ScheduledEvent {}

class LoadScheduleds extends ScheduledEvent {}

class UpdateScheduled extends ScheduledEvent {
  final ScheduledMovie scheduled;
  UpdateScheduled(this.scheduled);
}
