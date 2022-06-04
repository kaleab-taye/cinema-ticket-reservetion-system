import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_2/booking/bloc/booking_event.dart';
import 'package:sec_2/booking/bloc/booking_state.dart';
import 'package:sec_2/booking/repository/booking_repository.dart';
import 'package:sec_2/schedule/bloc/todo_event.dart';
import 'package:sec_2/schedule/bloc/todo_state.dart';
import 'package:sec_2/schedule/repository/schedule_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc(this.bookingRepository) : super(BookingsLoading()) {
    on<LoadBooking>(_onLoadBooking);
    on<DeleteBooking>(_onDeleteBooking);
    // on<UpdateMovie>(_onUpdateMovie);
  }

  void _onLoadBooking(LoadBooking event, Emitter emit) async {
    emit(BookingsLoading());
    final bookings = await bookingRepository.getAllBookings();
    if (bookings.hasError) {
      emit(BookingsLoadingFailed(bookings.error!));
    } else {
      // print(bookings.val![0].date);
      emit(BookingsLoaded(bookings.val!));
    }
  }

  void _onDeleteBooking(DeleteBooking event, Emitter emit) async {
    emit(BookingDeleting());
    final booking = await bookingRepository.deleteBooking(event.id);
    if (booking.hasError) {
      emit(ScheduleDeletingFailed(booking.error!));
    } else {
      emit(ScheduleDeleted());
    }
  }
}
