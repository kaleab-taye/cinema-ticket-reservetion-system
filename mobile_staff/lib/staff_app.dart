import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sec_2/booking/bloc/booking_bloc.dart';
import 'package:sec_2/booking/bloc/booking_event.dart';
import 'package:sec_2/booking/data_provider/booking_remote_provider.dart';
import 'package:sec_2/booking/repository/booking_repository.dart';
import 'package:sec_2/booking/ui/booking_list_screen.dart';
import 'package:sec_2/core/colors.dart';
import 'package:sec_2/movie/bloc/movie_bloc.dart';
import 'package:sec_2/movie/bloc/movie_event.dart';
import 'package:sec_2/movie/data_provider/movie_remote_provider.dart';
import 'package:sec_2/movie/repository/movie_repository.dart';
import 'package:sec_2/schedule/bloc/todo_bloc.dart';
import 'package:sec_2/schedule/bloc/todo_event.dart';
import 'package:sec_2/schedule/data_provider/schedule_remote_provider.dart';
import 'package:sec_2/schedule/repository/schedule_repository.dart';
import 'package:sec_2/schedule/ui/screens/schedule_list_screen.dart';

import 'login/repository/login_repository.dart';

class StaffApp extends StatefulWidget {
  const StaffApp({Key? key}) : super(key: key);

  @override
  State<StaffApp> createState() => _StaffAppState();
}

class _StaffAppState extends State<StaffApp> {
  int _currentIndex = 0;
  Widget? currentScreen;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

// BlocProvider(
//       create: (_) => movieBloc..add(LoadMovies()),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: StaffApp(),
//       ),
//     )
  final MovieBloc movieBloc = MovieBloc(MovieRepository(MovieRemoteProvider()));
  final ScheduleBloc scheduleBloc =
      ScheduleBloc(ScheduleRepository(ScheduleRemoteProvider()));
  final BookingBloc bookingBloc =
      BookingBloc(BookingRepository(BookingRemoteProvider()));
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => scheduleBloc..add(LoadSchedule())),
        BlocProvider(create: (_) => movieBloc..add(LoadMovies())),
        BlocProvider(create: (_) => bookingBloc..add(LoadBooking())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Col.secondary,
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Col.textColor,
                    ))
              ],
              title: _currentIndex == 0
                  ? Text(
                      "Schedule List",
                      style: TextStyle(
                          color: Col.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Booking List",
                      style: TextStyle(
                          color: Col.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
            ),
            body: IndexedStack(
              index: _currentIndex,
              // children: [MovieListScreen(), ReservationScreen()],
              children: [ScheduleListScreen(), BookingListScreen( bookingBloc: bookingBloc,)],
            ),
            floatingActionButton: Visibility(
              visible: _currentIndex == 0 ? true : false,
              child: FloatingActionButton(
                backgroundColor: Col.background,
                onPressed: () {
                  context.go('/NewSchedule');
                },
                child: Icon(
                  Icons.add,
                  color: Col.textColor,
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Col.secondary,
                fixedColor: Col.primary,
                unselectedItemColor: Col.background,
                unselectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                type: BottomNavigationBarType.fixed,
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie),
                    label: "Schedules",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chair),
                    label: "Bookings",
                  ),
                ])),
      ),
    );
  }
}
