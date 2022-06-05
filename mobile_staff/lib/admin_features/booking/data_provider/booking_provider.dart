import 'package:sec_2/admin_features/booking/model/booking_response.dart';

abstract class BookingProvider {
  Future<bool> deleteBooking(String id);
  Future<List<BookingResponse>> getAllBookings();

}
