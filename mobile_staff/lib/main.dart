import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sec_2/schedule/model/schedule.dart';
import 'package:sec_2/schedule/ui/screens/new_schedule_screen.dart';
import 'package:sec_2/schedule/ui/screens/schedule_detail_screen.dart';
import 'package:sec_2/staff_app.dart';
import 'package:sec_2/movie/index.dart';
import 'package:sec_2/movie/repository/movie_repository.dart';
import 'package:sec_2/movie/ui/screens/movie_detail_screen.dart';

void main() {
  runApp(CinemaReservationApp());
}

class RecipeApp extends StatelessWidget {
  RecipeApp({Key? key}) : super(key: key);

  final MovieBloc movieBloc = MovieBloc(MovieRepository(MovieRemoteProvider()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => movieBloc..add(LoadMovies()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StaffApp(),
      ),
    );
  }
}

class CinemaReservationApp extends StatelessWidget {
  CinemaReservationApp({Key? key}) : super(key: key);

  // static LocalStorage loginStorage = LocalStorage('loginData');

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Cinema Reservation',
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          // name: "home",
          builder: (BuildContext context, GoRouterState state) =>

              // loginStorage.getItem('loginData')!=null ? loginStorage.getItem('loginData')==true ?StaffApp() : LoginPage() :LoginPage(),
              StaffApp(),
          routes: <GoRoute>[
            GoRoute(
              path: 'Home',
              name: 'home',
              builder: (BuildContext context, GoRouterState state) =>
                  //     // loginStorage.getItem('loginData')!=null ? loginStorage.getItem('loginData')==true ?StaffApp() : LoginPage() :LoginPage(),
                  StaffApp(),
            ),
            GoRoute(
              path: 'MovieDetail',
              name: 'movieDetail',
              builder: (BuildContext context, GoRouterState state) =>
                  MovieDetailScreen(movie: state.extra! as Movie),
            ),
            GoRoute(
              path: 'ScheduleDetail',
              name: 'scheduleDetail',
              builder: (BuildContext context, GoRouterState state) =>
                  ScheduleDetail(schedule: state.extra! as Schedule),
              // ScheduleDetailScreen(scheduleId: state.extra! as String),
            ),
            GoRoute(
              path: 'NewSchedule',
              name: 'newSchedule',
              builder: (BuildContext context, GoRouterState state) =>
                  NewScheduleScreen(),
              // ScheduleDetailScreen(scheduleId: state.extra! as String),
            ),
            GoRoute(
              path: 'staff',
              builder: (BuildContext context, GoRouterState state) =>
                  const StaffApp(),
            ),

            // GoRoute(
            //   path: 'Profile',
            //   builder: (BuildContext context, GoRouterState state) =>
            //       ProfilePage(movie: state.extra! as Movie),
            // )
          ]),
      // GoRoute(
      //   path: '/staff',
      //   builder: (BuildContext context, GoRouterState state) =>
      //       const StaffApp(),
      // ),
    ],
  );
}
