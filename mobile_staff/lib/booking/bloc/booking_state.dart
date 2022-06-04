import 'package:sec_2/booking/model/booking_response.dart';
import 'package:sec_2/movie/index.dart';
import 'package:sec_2/schedule/model/schedule.dart';
import 'package:sec_2/schedule/model/schedule_response.dart';

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

class ScheduleUpdateSuccessful extends BookingState {}




class BookingDeleted extends BookingState {
}
class BookingDeleting extends BookingState {}

class BookingDeletingFailed extends BookingState {
  final String msg;
  BookingDeletingFailed(this.msg);
}

class BookingDelete extends BookingState{}
