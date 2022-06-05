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
    on<DeletingBooking>(_onDeletingBooking);
  }

  void _onLoadBookings(LoadBookings event, Emitter emit) async {
    emit(BookingsLoading());
    // await Future.delayed(const Duration(seconds: 1));
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
    await Future.delayed(const Duration(seconds: 1));
    try{
      await bookingRepository.book(event.userId, event.scheduleId);
      // emit(BookingUpdateSuccessful());
      emit(BookingMovieSuccessful());
    } catch (e){
      emit(BookingMovieFailed());
    }
  }

  void _onDeletingBooking(DeletingBooking event, Emitter emit) async {
    emit(DeletingBookingLoading());
    await Future.delayed(const Duration(seconds: 1));
    try{
      await bookingRepository.deleteBooking(event.bookId);
      // emit(BookingUpdateSuccessful());
      emit(DeletingBookingSuccessful());
    } catch (e){
      emit(DeletingBookingFailed());
    }
  }

}
