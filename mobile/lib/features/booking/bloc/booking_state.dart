
import '../model/booking_response.dart';

abstract class BookingState {}

class BookingsLoading extends BookingState {}

class BookingsLoaded extends BookingState {
  List<BookingResponse> bookings;
  BookingsLoaded(this.bookings);
}

class BookingsLoadingFailed extends BookingState {
  final String msg;
  BookingsLoadingFailed(this.msg);
}

class BookingMovieSuccessful extends BookingState {}

class BookingMovieFailed extends BookingState {}

class BookingMovieLoading extends BookingState {}

class BookingUpdateSuccessful extends BookingState {}

class DeletingBookingFailed extends BookingState {}

class DeletingBookingLoading extends BookingState {}

class DeletingBookingSuccessful extends BookingState {}
