import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/booking_repository.dart';
import 'bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;
  // final String query;

  BookingBloc(this.bookingRepository) : super(BookingsLoading()) {
    on<LoadBookings>(_onLoadBookings);
    // on<UpdateBooking>(_onUpdateBooking);
    on<BookingMovie>(_onBookingMovie);
  }

  void _onLoadBookings(LoadBookings event, Emitter emit) async {
    emit(BookingsLoading());
    await Future.delayed(const Duration(seconds: 3));
    final bookings = await bookingRepository.getAllBookings();
    if (bookings.hasError) {
      emit(BookingsLoadingFailed(bookings.error!));
    } else {
      emit(BookingsLoaded(bookings.val!));
    }
  }

  // void _onUpdateBooking(UpdateBooking event, Emitter emit) async {
  //   await bookingRepository.editBooking(event.booking.id, event.booking);
  //   emit(BookingUpdateSuccessful());
  // }

  void _onBookingMovie(BookingMovie event, Emitter emit) async {
    emit(BookingMovieLoading());
    await Future.delayed(const Duration(seconds: 3));
    try{
      await bookingRepository.book(event.userId, event.scheduleId);
      emit(BookingMovieSuccessful());
    } catch (e){
      emit(BookingMovieFailed());
    }
  }

}
