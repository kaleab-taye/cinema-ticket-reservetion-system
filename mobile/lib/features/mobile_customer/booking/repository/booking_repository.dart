
import 'package:royal_cinema/core/customer_core/utils/either.dart';

import '../data_provider/booking_provider.dart';
import '../model/booking.dart';
import '../model/booking_response.dart';

class BookingRepository {
  BookingProvider bookingProvider;
  BookingRepository(this.bookingProvider);

  Future<Either<List<BookingResponse>>> getAllBookings() async {
    try {
      final bookings = await bookingProvider.getAllBookings();
      return Either(val: bookings);
    } catch (err) {
      print(err);
      return Either(error: "Couldn't load Bookings");
    }
  }

  book(String userId, String scheduleId) async {
    try{
      await bookingProvider.book(userId, scheduleId);
    }
    catch(e){
      throw e;
    }
  }

  deleteBooking(String bookId) async {
    try{
      await bookingProvider.deleteBooking(bookId);
    }
    catch(e){
      throw e;
    }
  }
}
