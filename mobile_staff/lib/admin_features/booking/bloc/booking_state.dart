import 'package:sec_2/admin_features/booking/model/booking_response.dart';

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

class BookingUpdateSuccessful extends BookingState {}




class BookingDeleted extends BookingState {
}
class BookingDeleting extends BookingState {}

class BookingDeletingFailed extends BookingState {
  final String msg;
  BookingDeletingFailed(this.msg);
}

class BookingDelete extends BookingState{}
