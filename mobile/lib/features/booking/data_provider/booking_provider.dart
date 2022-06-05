
import '../model/booking.dart';
import '../model/booking_response.dart';

abstract class BookingProvider {
  Future<void> addBooking(BookingMovie booking);
  Future<void> editBooking(String id, BookingMovie booking);
  Future<BookingMovie?> getBooking(String id);
  Future<List<BookingResponse>> getAllBookings();
  Future<void> book(String userId, String scheduleId);
  Future<void> deleteBooking(String bookId);
}
