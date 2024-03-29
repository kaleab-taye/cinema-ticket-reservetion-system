// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:royal_cinema/core/customer_core/api_data.dart';
import 'package:royal_cinema/features/mobile_customer/user/data_provider/local_data_provider.dart';
import 'package:royal_cinema/features/mobile_customer/booking/bloc/bloc.dart';
import 'package:royal_cinema/features/mobile_customer/booking/bloc/booking_bloc.dart';
import 'package:royal_cinema/features/mobile_customer/home/bloc/bloc.dart';
import 'package:royal_cinema/features/mobile_customer/user/bloc/bloc.dart';
import 'package:royal_cinema/features/mobile_customer/user/model/user.dart';

import '../../../../../core/customer_core/utils/colors.dart';
import '../../../user/bloc/user_bloc.dart';
import '../widget/search_widget.dart';

class ScheduledListScreen extends StatelessWidget {
  ScheduledListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearch(),
          BlocBuilder<ScheduledBloc, ScheduledState>(
            buildWhen: (p, c) => c is! ScheduleUpdateSuccessful,
            builder: (_, ScheduledState state) {
              if (state is ScheduledsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ScheduledsLoadingFailed) {
                return Center(
                  child: Text(state.msg),
                );
              }

              if (state is ScheduledsLoaded) {
                return ListView.builder(
                    itemCount: state.scheduleds.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return daysPresenter(context, i);
                    });
              }

              return const Text("should never happen");
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
    return BlocBuilder<ScheduledBloc, ScheduledState>(
      buildWhen: (p, c) => c is! ScheduleUpdateSuccessful,
      builder: (_, ScheduledState state) {
        if (state is ScheduledsLoadingFailed) {
          return Center(
            child: Text(state.msg),
          );
        }

        if (state is ScheduledsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  state.scheduleds[i].date,
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
                height: 270,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Col.secondary.withOpacity(0.3),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: state.scheduleds[i].schedules.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
                          state.scheduleds[i].schedules[index].startTime);
                      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
                          state.scheduleds[i].schedules[index].endTime);
                      String formattedStartTime =
                          DateFormat('h:mma').format(startTime);
                      String formattedEndTime =
                          DateFormat('h:mma').format(endTime);

                      return GestureDetector(
                        onTap: () async {
                          String schedule_detail = jsonEncode(
                              state.scheduleds[i].schedules[index].toJson());
                          context.goNamed(
                            'schedule_details',
                            params: {'schedule_id': schedule_detail},
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "$formattedStartTime - $formattedEndTime",
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${state.scheduleds[i].schedules[index].price}",
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "${ApiData.imageBaseUrl}/${state.scheduleds[i].schedules[index].movie.imageUrl}"),
                                  ),
                                  color: Col.textColor),
                              width: 150,
                              height: 130,
                              margin: EdgeInsets.only(right: 10),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 150,
                              child: Center(
                                child: Text(
                                  "${state.scheduleds[i].schedules[index].movie.title}",
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
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
                                            "${state.scheduleds[i].schedules[index].price} birr is going to be deducted from your balance to book ${state.scheduleds[i].schedules[index].movie.title} from $formattedStartTime to $formattedEndTime",
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

                                                LocalDbProvider localDbProvider = LocalDbProvider();
                                                User userOut = await localDbProvider.getUser();

                                                final bookBloc = BlocProvider.of<BookingBloc>(context);
                                                bookBloc.add(BookingMovie(userOut.id, state.scheduleds[i].schedules[index].id));

                                                final userBloc = BlocProvider.of<UserBloc>(context);
                                                userBloc.add(UpdateBalance(state.scheduleds[i].schedules[index].price));

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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 1),
                                child: Text(
                                  "Book",
                                  style: TextStyle(
                                      color: Col.secondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Col.textColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        }

        return const Text("should never happen");
      },
    );
  }
}
