import 'package:royal_cinema/features/mobile_staff/booking/model/booking.dart';

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
