
import 'booking.dart';

class BookingResponse {
  // final String? id;
  final String date;
  final List<BookingMovie> bookings;
  BookingResponse(
      {
        required this.date,
        required this.bookings,
      }){

  }
}