import 'package:sec_2/booking/model/booking_response.dart';

abstract class BookingProvider {
  Future<bool> deleteBooking(String id);
  Future<List<BookingResponse>> getAllBookings();

}
