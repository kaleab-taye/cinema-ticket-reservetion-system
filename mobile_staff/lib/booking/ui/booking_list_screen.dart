import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sec_2/booking/bloc/booking_bloc.dart';
import 'package:sec_2/booking/bloc/booking_event.dart';
import 'package:sec_2/booking/bloc/booking_state.dart';
import 'package:sec_2/booking/data_provider/booking_remote_provider.dart';
import 'package:sec_2/booking/model/booking.dart';
import 'package:sec_2/booking/repository/booking_repository.dart';
import 'package:sec_2/core/colors.dart';

class BookingListScreen extends StatelessWidget {
  BookingListScreen({Key? key, required this.bookingBloc}) : super(key: key) {}

  final BookingBloc bookingBloc;

  final BookingBloc bookingRemoveBloc =
      BookingBloc(BookingRepository(BookingRemoteProvider()));

  Widget ShowBookings(List<Booking> bookingList, BuildContext context,
      BookingBloc bookingBloc) {
    // print(bookingList);
// BlocProvider(
//         create: (_) => scheduleBlocupdate,
//         child:
    return BlocProvider(
        create: (_) => bookingRemoveBloc,
        child:
            // Text("chacha");
            Container(
              
              child: Column(children: [
          for (var booking in bookingList)
              Container(
                
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Col.secondary),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //
                          //
                          children: [
                            Row(
                              children: [
                                Text(
                                  DateFormat.Hms().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          booking.schedule!.startTime)),
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat.Hms().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          booking.schedule!.endTime)),
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            BlocBuilder<BookingBloc, BookingState>(
                                // buildWhen: (p, c) => c is! BookingUpdateSuccessful,
                                builder: (_, BookingState state) {
                              if (state is BookingDeleting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is BookingDeletingFailed) {
                                return Center(
                                  child: Text(state.msg),
                                );
                              }

                              if (state is BookingDeleted) {
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Col.textColor,
                                        backgroundColor: Col.secondary),
                                    onPressed: () {
                                      
                                      bookingRemoveBloc
                                          .add(DeleteBooking(booking.id!));
                                          bookingBloc..add(LoadBooking());

                                      // context.go('/Home');
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                );
                              }
                              return Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Col.textColor,
                                        backgroundColor: Col.secondary),
                                    onPressed: () {
                                      // bookingBloc..add(CreateSchedule(temp));
                                      bookingRemoveBloc
                                          .add(DeleteBooking(booking.id!));
                                      // context.go('/Home');
                                    },
                                    child: Icon(Icons.delete),
                                  ));
                            })
                          ],
                        ),
                        Text(
                          booking.schedule!.movie!.title,
                          style: TextStyle(
                              color: Col.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          booking.user!.fullName,
                          // booking.schedule!.movie!.title,
                          style: TextStyle(
                              color: Col.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          booking.user!.phone,
                          // booking.schedule!.movie!.title,
                          style: TextStyle(
                              color: Col.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                  ),
                ),
              )
        ]),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      // buildWhen: (p, c) => c is! BookingUpdateSuccessful,
      builder: (_, BookingState state) {
        print(state);
        if (state is BookingsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BookingsLoadingFailed) {
          return Center(
            child: Text(state.msg),
          );
        }

        if (state is BookingsLoaded) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Col.background),
              child: ListView.builder(
                  itemCount: state.bookings.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                          // margin: EdgeInsets.all( 10),
                          child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  // "chalchi",
                                  state.bookings[index].date,
                                  style: TextStyle(
                                      color: Col.secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ShowBookings(state.bookings[index].bookings,
                                context, bookingBloc),
                          )
                        ],
                      )),
                    );
                  }),
            ),
            // ]),
          );
        }
        print(state);
        return const Text("should never happen");
      },
    );
  }
}
