import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sec_2/admin_features/schedule/bloc/todo_bloc.dart';
import 'package:sec_2/admin_features/schedule/bloc/todo_state.dart';
import 'package:sec_2/admin_features/schedule/model/schedule.dart';
import 'package:sec_2/core/api_data.dart';
import 'package:sec_2/core/colors.dart';

class ScheduleListScreen extends StatelessWidget {
  ScheduleListScreen({Key? key}) : super(key: key) {}

  Widget ShowSchedules(List<Schedule> scheduleList, BuildContext context) {
    return Column(children: [
      for (var schedule in scheduleList)
        GestureDetector(
          onTap: () => {
            // print(schedule.capacity),
            context.pushNamed(
              'scheduleDetail',
              extra: schedule,
            )
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Col.secondary),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        DateFormat.Hms().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                schedule.startTime)),
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
                                schedule.endTime)),
                        style: TextStyle(
                            color: Col.textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Image(
                  //   height: 200,
                  //   width: 200,
                  //   image: NetworkImage(
                  //   '${apiData.baseUrl}//${schedule.movie!.imageUrl}'
                  // )),
                  Text(
                    schedule.movie!.title,
                    style: TextStyle(
                        color: Col.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ),
          ),
        )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (p, c) => c is! ScheduleUpdateSuccessful,
      builder: (_, ScheduleState state) {
        print(state);
        if (state is SchedulesLoading) {
          
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SchedulesLoadingFailed) {
          return Center(
            child: Text(state.msg),
          );
        }

        if (state is SchedulesLoaded) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Col.background),
              child: ListView.builder(
                  itemCount: state.schedules.length,
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
                                  state.schedules[index].date,
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
                              child: ShowSchedules(
                                  state.schedules[index].schedules, context))
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
