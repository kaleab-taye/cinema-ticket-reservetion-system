import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/mobile_staff/booking/bloc/booking_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/booking/bloc/booking_event.dart';
import 'package:royal_cinema/features/mobile_staff/booking/data_provider/booking_remote_provider.dart';
import 'package:royal_cinema/features/mobile_staff/booking/repository/booking_repository.dart';
import 'package:royal_cinema/features/mobile_staff/booking/ui/booking_list_screen.dart';
import 'package:royal_cinema/features/mobile_staff/index/data_provider/local_user_data_provider.dart';
import 'package:royal_cinema/features/mobile_staff/index/repository/index_repository.dart';
import 'package:royal_cinema/features/mobile_staff/movie/data_provider/movie_remote_provider.dart';
import 'package:royal_cinema/features/mobile_staff/movie/index.dart';
import 'package:royal_cinema/features/mobile_staff/movie/repository/movie_repository.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/bloc/todo_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/bloc/todo_event.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/data_provider/schedule_remote_provider.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/repository/schedule_repository.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/ui/screens/schedule_list_screen.dart';
import 'package:royal_cinema/core/staff_core/colors.dart';

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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: null,
    );
    Widget continueButton = FlatButton(
      child: Text("Logout"),
      onPressed: () {
        IndexRepository indexRep = IndexRepository(IndexDataProvider());
        indexRep.logoutStaff();
        context.goNamed('login');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("you are about to logout you sure you want to continue"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                    child: GestureDetector(
                      onTap: (() => {showAlertDialog(context)}),
                      child: Icon(
                        Icons.logout,
                        size: 50,
                        color: Col.textColor,
                      ),
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
              children: [
                ScheduleListScreen(),
                BookingListScreen(
                  bookingBloc: bookingBloc,
                )
              ],
            ),
            floatingActionButton: Visibility(
              visible: _currentIndex == 0 ? true : false,
              child: FloatingActionButton(
                backgroundColor: Col.background,
                onPressed: () {
                  context.goNamed('newSchedule');
                },
                child: Icon(
                  Icons.add,
                  color: Col.textColor,
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: BottomNavigationBar(
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
                  ]),
            )),
      ),
    );
  }
}
