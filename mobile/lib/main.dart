// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/local_data_provider.dart';
import 'package:royal_cinema/features/auth/login/login.dart';
import 'package:royal_cinema/features/auth/signup/bloc/bloc.dart';
import 'package:royal_cinema/features/auth/signup/data_provider/data_provider.dart';
import 'package:royal_cinema/features/auth/signup/repository/repository.dart';
import 'package:royal_cinema/features/auth/signup/screens/screens.dart';
import 'package:royal_cinema/features/booking/bloc/bloc.dart';
import 'package:royal_cinema/features/booking/screens/booking_details_screen.dart';
import 'package:royal_cinema/features/home/data_provider/schedule_remote_provider.dart';
import 'package:royal_cinema/features/home/index.dart';
import 'package:royal_cinema/features/home/repository/movie_repository.dart';
import 'package:royal_cinema/features/home/repository/schedule_repository.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_details_screen.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_home_screen.dart';
import 'package:royal_cinema/features/home/ui/screens/scheduled_details_screen.dart';
import 'package:royal_cinema/features/home/ui/screens/splash_screen.dart';
import 'package:royal_cinema/features/user/bloc/bloc.dart';
import 'package:royal_cinema/features/user/data_provider/user_remote_provider.dart';
import 'package:royal_cinema/features/user/repository/user_repository.dart';

import 'features/auth/login/bloc/auth_bloc.dart';
import 'features/auth/login/screens/login.dart';
import 'features/booking/bloc/booking_bloc.dart';
import 'features/booking/data_provider/booking_remote_provider.dart';
import 'features/booking/repository/booking_repository.dart';
import 'features/home/bloc/bloc.dart';
import 'features/user/screens/editProfile.dart';
import 'features/user/screens/profile.dart';

Future<void> main() async {

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {

          return MaterialPage(
            key: state.pageKey,
            child:SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {

          return MaterialPage(
            key: state.pageKey,
            child:LoginScreen(),
          );
        },
      ),
      GoRoute(
        // name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) {

          // String user_id = state.params['user_id']!;

          return MaterialPage(
            key: state.pageKey,
            child: Profile(
              // id: user_id,
            ),
          );
        },
      ),
      GoRoute(
        path: '/editProfile',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: EditProfile(),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: SignUpScreen(),
        ),
      ),
      GoRoute(
          path: '/home',
          pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: MovieHomePage(),
              ),
          routes: [
            // GoRoute(
            //   name: 'movie_details',
            //   path: ':id',
            //   pageBuilder: (context, state) {
            //     // final movie = _movieFrom(state.params['id']!);
            //     String id = state.params['id']!;
            //
            //     //movie = bloc.getMovie(id);
            //     return MaterialPage(
            //       key: state.pageKey,
            //       child: MovieDetailsScreen(
            //         id: id,
            //       ),
            //     );
            //   },
            // ),
            GoRoute(
              name: 'schedule_details',
              path: ':schedule_id',
              pageBuilder: (context, state) {
                // final movie = _movieFrom(state.params['id']!);
                String schedule_id = state.params['schedule_id']!;

                //movie = bloc.getMovie(id);
                return MaterialPage(
                  key: state.pageKey,
                  child: ScheduleDetailsScreen(
                    schedule_id: schedule_id
                  ),
                );
              },
            ),
          ]),
      GoRoute(
        name: 'booking_details',
        path: '/booking_id',
        pageBuilder: (context, state) {
          // final movie = _movieFrom(state.params['id']!);
          String booking_id = state.params['booking_id']!;

          //movie = bloc.getMovie(id);
          return MaterialPage(
            key: state.pageKey,
            child: BookingDetailsScreen(
                booking_id: booking_id
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );

  final MovieBloc movieBloc = MovieBloc(MovieRepository(MovieRemoteProvider()));
  final ScheduledBloc scheduledBloc = ScheduledBloc(ScheduledRepository(ScheduledRemoteProvider()));
  final BookingBloc bookingBloc = BookingBloc(BookingRepository(BookingRemoteProvider()));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(LoginRepository(LoginDataProvider()))),
        BlocProvider(create: (_) => SignUpBloc(SignUpRepository(SignUpDataProvider()))),
        BlocProvider(create: (_) => movieBloc..add(LoadMovies())),
        BlocProvider(create: (_) => scheduledBloc..add(LoadScheduleds())),
        BlocProvider(create: (_) => bookingBloc..add(LoadBookings())),
        BlocProvider(create: (_) => UserBloc(UserRepository(UserRemoteProvider()))),
      ],
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
