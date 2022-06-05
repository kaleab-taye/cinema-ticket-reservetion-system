
abstract class BookingEvent {}

class LoadBooking extends BookingEvent {}


class DeleteBooking extends BookingEvent {
  final String id;
  DeleteBooking(this.id);
}

