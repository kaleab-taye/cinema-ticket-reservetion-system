
import 'package:royal_cinema/core/utils/either.dart';

import '../data_provider/booking_provider.dart';
import '../model/booking.dart';
import '../model/booking_response.dart';

class BookingRepository {
  BookingProvider bookingProvider;
  BookingRepository(this.bookingProvider);

  // Future<List<BookingMovie>> getBookingsWithTitle(String id) async {
  //   final bookings = await bookingProvider.getAllBookings();
  //   return bookings.where((booking) => booking.id == id).toList();
  // }

  Future<Either<List<BookingResponse>>> getAllBookings() async {
    try {
      final bookings = await bookingProvider.getAllBookings();
      return Either(val: bookings);
    } catch (err) {
      print(err);
      return Either(error: "Couldn't load Bookings");
    }
  }

  Future<Either<BookingMovie>> getBooking(String id) async {
    try {
      final booking = await bookingProvider.getBooking(id);
      return Either(val: booking);
    } catch (err) {
      return Either(error: "Bookings not found");
    }
  }

  addBooking(BookingMovie booking) async {
    // check for profanity
    // booking.description.contains("sidib");
    final newBooking = BookingMovie(
        userId: booking.userId,
        scheduleId: booking.scheduleId,
        schedule: booking.schedule,
        user: booking.user
    );

    await bookingProvider.addBooking(newBooking);
  }

  book(String userId, String scheduleId) async {
    try{
      await bookingProvider.book(userId, scheduleId);
    }
    catch(e){
      throw e;
    }
  }

  Future<Either<String>> editBooking(String id, BookingMovie booking) async {
    try {
      final newBooking = BookingMovie(
          userId: booking.userId,
          scheduleId: booking.scheduleId,
          schedule: booking.schedule,
          user: booking.user
      );
      await bookingProvider.editBooking(id, newBooking);
      return Either(val: "");
    } catch (err) {
      return Either(error: "Bookings not found");
    }
  }
}
