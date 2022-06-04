import 'package:sec_2/booking/model/booking.dart';

class BookingResponse {
  final String date;
  final List<Booking> bookings;
  BookingResponse(
      {
      required this.date,
      required this.bookings,
      }) {
  }
}
