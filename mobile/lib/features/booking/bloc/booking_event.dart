import '../model/booking.dart';

abstract class BookingEvent {}

class LoadBookings extends BookingEvent {}

class BookingMovie extends BookingEvent {
  final userId;
  final scheduleId;
  BookingMovie(this.userId, this.scheduleId);
}

class DeletingBooking extends BookingEvent {
  final bookId;
  DeletingBooking(this.bookId);
}

class UpdateBooking extends BookingEvent {
  final BookingMovie booking;
  UpdateBooking(this.booking);
}
