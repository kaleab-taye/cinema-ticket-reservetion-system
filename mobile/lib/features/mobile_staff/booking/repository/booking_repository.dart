import 'package:royal_cinema/features/mobile_staff/booking/data_provider/booking_provider.dart';
import 'package:royal_cinema/features/mobile_staff/booking/model/booking_response.dart';
import 'package:royal_cinema/features/mobile_staff/utils/either.dart';

class BookingRepository {
  BookingProvider bookingProvider;
  BookingRepository(this.bookingProvider);

  Future<Either<List<BookingResponse>>> getAllBookings() async {
    
    try {
      final bookings = await bookingProvider.getAllBookings();
      return Either(val: bookings);
    } catch (err) {
      return Either(error: "Couldn't load schedules");
    }
  }

  Future<Either<bool>> deleteBooking(String id) async {
    try {
      final booking = await bookingProvider.deleteBooking(id);
      return Either(val: booking);
    } catch (err) {
      return Either(error: "Schedule couldn't be Deleted");
    }
  }
}
