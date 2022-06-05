import 'package:royal_cinema/features/mobile_staff/booking/model/booking_response.dart';

abstract class BookingProvider {
  Future<bool> deleteBooking(String id);
  Future<List<BookingResponse>> getAllBookings();

}
