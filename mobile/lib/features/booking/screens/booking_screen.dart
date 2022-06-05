// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/booking/bloc/bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../home/ui/widget/search_widget.dart';
import '../../user/bloc/user_bloc.dart';
import '../../user/bloc/user_event.dart';

class BookedListScreen extends StatefulWidget {
  const BookedListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BookedListScreenState createState() => _BookedListScreenState();
}

class _BookedListScreenState extends State<BookedListScreen> {
  @override
  void initState() {
    final bookBloc = BlocProvider.of<BookingBloc>(context);
    bookBloc.add(LoadBookings());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearch(),
          Center(
            child: Text(
              "Booked",
              style: TextStyle(
                color: Col.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          BlocBuilder<BookingBloc, BookingState>(
            buildWhen: (p, c) => c is! BookingUpdateSuccessful,
            builder: (_, BookingState state) {
              if (state is BookingsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is BookingsLoadingFailed) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text(state.msg),
                      SizedBox(height: 30,),
                      RaisedButton(onPressed: () {
                        final bookBloc = BlocProvider.of<BookingBloc>(context);
                        bookBloc.add(LoadBookings());
                      },
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: Col.primary,
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                );
              }

              if (state is BookingsLoaded) {
                return ListView.builder(
                    itemCount: state.bookings.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return daysPresenter(context, i);
                    });
              }

              final bookBloc = BlocProvider.of<BookingBloc>(context);
              bookBloc.add(LoadBookings());

              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: "Search ...",
        hintText: 'Search ...',
      );

  Widget daysPresenter(BuildContext context, int i) {
    return BlocBuilder<BookingBloc, BookingState>(
      buildWhen: (p, c) => c is! BookingUpdateSuccessful,
      builder: (_, BookingState state) {
        if (state is BookingsLoadingFailed) {
          return Center(
            child: Text(state.msg),
          );
        }

        if (state is BookingsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  state.bookings[i].date,
                  style: TextStyle(
                      color: Col.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 260,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Col.secondary.withOpacity(0.3),
                ),
                child: ListView.builder(
                    itemCount: state.bookings[i].bookings.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
                          state.bookings[i].bookings[index].schedule.startTime);
                      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
                          state.bookings[i].bookings[index].schedule.endTime);
                      String formattedStartTime =
                          DateFormat('h:mma').format(startTime);
                      String formattedEndTime =
                          DateFormat('h:mma').format(endTime);

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // final result = await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => BookingDetailsScreen(
                              //       booking: state.bookings[index],
                              //     ),
                              //   ),
                              // );
                              //
                              // if (result == null) return;
                              //
                              // final bookingBloc = BlocProvider.of<BookingBloc>(context);
                              // bookingBloc.add(Loadbookings());
                              // String booking = jsonEncode(state.bookings[index].toJson());
                              // context.goNamed(
                              //   'booking_details',
                              //   params: {'id': booking},
                              // );
                              // String movie = jsonEncode(
                              //     state.bookings[i].bookings[index].toJson());
                              // context.goNamed(
                              //   'booking_details',
                              //   params: {'booking_id': movie},
                              // );
                              String schedule_detail = jsonEncode(state
                                  .bookings[i].bookings[index].schedule
                                  .toJson());
                              context.goNamed(
                                'schedule_details',
                                params: {'schedule_id': schedule_detail},
                              );
                            },
                            // context.go("/booking_details");
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "$formattedStartTime - $formattedEndTime",
                                      style: TextStyle(
                                          color: Col.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text(
                                      "\$${state.bookings[i].bookings[index].schedule.price}",
                                      style: TextStyle(
                                          color: Col.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "${ApiData.imageBaseUrl}/${state.bookings[i].bookings[index].schedule.movie.imageUrl}"),
                                      ),
                                      color: Col.textColor),
                                  width: 150,
                                  height: 130,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Stack(
                                    children: [],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 150,
                                  child: Center(
                                    child: Text(
                                      "${state.bookings[i].bookings[index].schedule.movie.title}",
                                      style: TextStyle(
                                          color: Col.textColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Col.background,
                                        title: Text(
                                          "ROYAL CINEMA",
                                          style: TextStyle(
                                            color: Col.primary,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        content: Text(
                                          "Half of the price of your booking which is ${state.bookings[i].bookings[index].schedule.price~/2} birr is going to be returned to your balance",
                                          style: TextStyle(
                                            color: Col.textColor,
                                            fontSize: 20,
                                            fontFamily: 'Nunito',
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ),
                                          FlatButton(
                                            onPressed: () async {
                                              // LocalDbProvider localDbProvider = LocalDbProvider();
                                              // User userOut = await localDbProvider.getUser();

                                              final deleteBloc = BlocProvider.of<BookingBloc>(context);
                                              deleteBloc.add(DeletingBooking(state.bookings[i].bookings[index].id));

                                              final userBloc =
                                              BlocProvider.of<UserBloc>(context);
                                              userBloc.add(UpdateBalance(-state.bookings[i].bookings[index].schedule.price~/2));

                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ),
                                        ],
                                        elevation: 10.0,
                                      );
                                    });
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
        }

        final bookBloc = BlocProvider.of<BookingBloc>(context);
        bookBloc.add(LoadBookings());

        return const Text("should never happen");
      },
    );
  }
}
