import 'package:sec_2/admin_features/booking/data_provider/booking_provider.dart';
import 'package:sec_2/admin_features/booking/model/booking_response.dart';
import 'package:sec_2/admin_features/utils/either.dart';

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
