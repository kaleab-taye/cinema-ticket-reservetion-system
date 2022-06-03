// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/home/bloc/bloc.dart';

import '../../../../core/utils/colors.dart';
import '../widget/search_widget.dart';

class ScheduledListScreen extends StatelessWidget {
  ScheduledListScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledBloc, ScheduledState>(
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
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearch(),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Today's",
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
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(color: Col.secondary),
                  child: ListView.builder(
                      itemCount: state.scheduleds.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            // final result = await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => ScheduledDetailsScreen(
                            //       scheduled: state.scheduleds[index],
                            //     ),
                            //   ),
                            // );
                            //
                            // if (result == null) return;
                            //
                            // final scheduledBloc = BlocProvider.of<ScheduledBloc>(context);
                            // scheduledBloc.add(Loadscheduleds());
                            String scheduled = jsonEncode(state.scheduleds[index].toJson());
                            context.goNamed(
                              'scheduled_details',
                              params: {'id': scheduled},
                            );
                          },
                          // context.go("/scheduled_details");
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "${ApiData.baseUrl}/${state.scheduleds[index].movie.imageUrl}"),),
                                color: Col.textColor),
                            width: 150,
                            margin: EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite),
                                    color: Col.secondary,
                                    iconSize: 28,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(state.scheduleds[index].startingTime.toString(),
                                    style: TextStyle(
                                        color: Col.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        }

        return const Text("should never happen");
      },
    );
  }

  Widget buildSearch() => SearchWidget(
    text: "Search ...",
    hintText: 'Search ...',
  );
}
