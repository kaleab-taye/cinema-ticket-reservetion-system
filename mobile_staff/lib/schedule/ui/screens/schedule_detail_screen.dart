import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sec_2/core/colors.dart';
import 'package:sec_2/movie/index.dart';
import 'package:sec_2/movie/repository/movie_repository.dart';
import 'package:sec_2/schedule/bloc/todo_bloc.dart';
import 'package:sec_2/schedule/bloc/todo_event.dart';
import 'package:sec_2/schedule/bloc/todo_state.dart';
import 'package:sec_2/schedule/data_provider/schedule_remote_provider.dart';
import 'package:sec_2/schedule/model/schedule.dart';
import 'package:sec_2/schedule/repository/schedule_repository.dart';

class ScheduleDetail extends StatefulWidget {
  ScheduleDetail({
    Key? key,
    required this.schedule,
  }) : super(key: key) {
    final scheduleData = {
      "id": schedule.id,
      // "movieId": schedule.movieId,
      "movieId": schedule.movieId,
      "startTime": schedule.startTime,
      "endTime": schedule.endTime,
      "capacity": schedule.capacity,
      "price": schedule.price,
    };
  }

  final Schedule schedule;

  @override
  State<ScheduleDetail> createState() => ScheduleDetailState();
}

class ScheduleDetailState extends State<ScheduleDetail> {
  // widget.schedule
  // final data = scheduleData;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  List<String> movieTitleList = ['NoSelection'];
  Map<String, String> idMap = {};
  Map<String, Movie> movieMap = {};

  // String movieId;
  // print("hello");

  Future<DateTime> pickDateTime() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (date == null) DateTime.now();

    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) DateTime.now();

    final dateTime =
        DateTime(date!.year, date.month, date.day, time!.hour, time.minute);

    return dateTime;
  }

  final ScheduleBloc scheduleBlocupdate =
      ScheduleBloc(ScheduleRepository(ScheduleRemoteProvider()));
  final MovieBloc movieBloc = MovieBloc(MovieRepository(MovieRemoteProvider()));

  Widget getMovieSelectionWidget(BuildContext context) {
    return BlocProvider(
      create: (_) => movieBloc..add(LoadMovies()),
      child: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (p, c) => c is! UpdateSuccessful,
          builder: (_, MovieState state) {
            if (state is MoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MoviesLoadingFailed) {
              return Center(
                child: Text(state.msg),
              );
            }

            if (state is MoviesLoaded) {
              movieTitleList = ['NoSelection'];
              idMap = {};
              movieMap = {};
              for (var movie in state.movies) {
                movieTitleList.add("${movie.title}");
                idMap[movie.title] = movie.id!;
                movieMap[movie.title] = movie;
              }
              // initialMovieSelection = this.widget.schedule.capacity.toString();
              return DropdownButton<String>(
                  style: TextStyle(
                      // backgroundColor: Col.secondary,
                      color: Col.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  value: initialMovieSelection,
                  icon: const Icon(Icons.arrow_downward),
                  items: movieTitleList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      initialMovieSelection = newValue!;
                      movieName = newValue;
                    });

                    // initialMovieSelection = newValue!;
                  });
            }
            return Text("error loading movies");
          }),
    );
  }

  Widget stateChecker(ScheduleState state, BuildContext context) {
    if (state is ScheduleUpdating) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ScheduleUpdatingFailed) {
      return Center(
        child: Text(state.msg),
      );
    }

    if (state is ScheduleUpdate) {
      return Text('Uptade Schedule');
    }
    if (state is ScheduleUpdated) {
      return Column(children: [Text('Successfully Updated'), Text(" Go back")]);
    }
    return Text("Update Schedule");
  }

  final capacityCtrl = TextEditingController();

  final priceCtrl = TextEditingController();

  final scheduleId = TextEditingController();


  late String movieName;

  String initialMovieSelection = 'NoSelection';

  @override
  void initState() {
    super.initState();

    capacityCtrl.text = widget.schedule.capacity.toString();
    priceCtrl.text = widget.schedule.price.toString();

    startTime = DateTime.fromMillisecondsSinceEpoch(widget.schedule.startTime);
    endTime = DateTime.fromMillisecondsSinceEpoch(widget.schedule.endTime);
    initialMovieSelection = widget.schedule.movie!.title;

    scheduleId.text = widget.schedule.id!;
    movieName = widget.schedule.movie!.title;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => scheduleBlocupdate,
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
            buildWhen: (p, c) => c is! ScheduleUpdateSuccessful,
            builder: (_, ScheduleState state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Schedule Edit",
                    style: TextStyle(
                        color: Col.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Col.secondary,
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                      width: MediaQuery.of(context).size.width,
                      color: Col.background,
                      child: Column(
                        // mainAxisSize : MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Col.secondary,
                              
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(

                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Start Time",
                                      style: TextStyle(
                                          color: Col.textColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    startTime.toString(),
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        DateTime selected = await pickDateTime();
                                        setState(() {
                                          startTime = selected;
                                        });
                                        // print(await selectedTime);
                                      },
                                      child: Text("select time")),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Col.secondary,
                              
                              ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "End Time",
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  endTime.toString(),
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      DateTime selected = await pickDateTime();
                                      setState(() {
                                        endTime = selected;
                                      });
                                      // print(await selectedTime);
                                    },
                                    child: Text("select time")),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Col.secondary,
                              
                              ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Capacity",
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextFormField(
                                  // initialValue:
                                  // //  scheduleData,
                                  // this.widget.schedule.capacity.toString(),
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: capacityCtrl,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Col.secondary,
                              
                              ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "price",
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextFormField(
                                  // initialValue:
                                  //     this.widget.schedule.price.toString(),
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: priceCtrl,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Col.secondary,
                              
                              ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Movie",
                                    style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                getMovieSelectionWidget(context),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Col.textColor,
                                backgroundColor: Col.secondary),
                            onPressed: () {
                              Schedule temp = Schedule(
                                  id: scheduleId.text.toString(),
                                  seatsLeft: int.parse(capacityCtrl.text),
                                  price: int.parse(priceCtrl.text),
                                  capacity: int.parse(capacityCtrl.text),
                                  movie: movieMap[movieName],
                                  movieId: idMap[movieName]!,
                                  startTime: startTime.millisecondsSinceEpoch,
                                  endTime: endTime.millisecondsSinceEpoch);
                              scheduleBlocupdate..add(UpdateSchedule(temp));
                
                              context.pop();
                            },
                            child: stateChecker(state, context),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Col.textColor,
                                backgroundColor: Col.secondary),
                            onPressed: () {
                
                              scheduleBlocupdate..add(DeleteSchedule(scheduleId.text.toString()));
                
                              context.pop();
                            },
                            child: Text("Delete Schedule"),
                          ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       print(this.widget.schedule.capacity);
                          //     },
                          //     child: Text("test"))
                        ],
                      )),
                ),
              );
            }));
  }
}
