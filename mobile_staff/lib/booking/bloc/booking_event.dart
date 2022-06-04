import 'package:sec_2/movie/index.dart';
import 'package:sec_2/schedule/model/schedule.dart';

abstract class BookingEvent {}

class LoadBooking extends BookingEvent {}


class DeleteBooking extends BookingEvent {
  final String id;
  DeleteBooking(this.id);
}

