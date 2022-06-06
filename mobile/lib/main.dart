// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/mobile_customer/user/data_provider/local_data_provider.dart';
import 'package:royal_cinema/features/mobile_customer/auth/login/bloc/auth_bloc.dart';
import 'package:royal_cinema/features/mobile_customer/auth/signup/bloc/signup_bloc.dart';
import 'package:royal_cinema/features/mobile_customer/booking/bloc/booking_event.dart';
import 'package:royal_cinema/features/mobile_customer/home/bloc/scheduledmovie_bloc.dart';
import 'package:royal_cinema/features/mobile_customer/home/bloc/scheduledmovie_event.dart';
import 'package:royal_cinema/features/mobile_customer/user/bloc/user_bloc.dart';
import 'package:royal_cinema/features/mobile_customer/user/data_provider/user_remote_provider.dart';
import 'package:royal_cinema/features/mobile_customer/user/repository/user_repository.dart';
import 'package:royal_cinema/features/mobile_staff/index/ui/index_screen.dart';
import 'package:royal_cinema/features/mobile_staff/login/ui/login_page.dart';
import 'package:royal_cinema/features/mobile_staff/movie/model/movie.dart';
import 'package:royal_cinema/features/mobile_staff/movie/ui/screens/movie_detail_screen.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/model/schedule.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/ui/screens/new_schedule_screen.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/ui/screens/schedule_detail_screen.dart';
import 'package:royal_cinema/features/mobile_staff/staff_app.dart';
import 'package:royal_cinema/features/startup_screen.dart';

import 'features/mobile_customer/auth/login/data_provider/login_data.dart';
import 'features/mobile_customer/auth/login/repository/login_repository.dart';
import 'features/mobile_customer/auth/login/screens/login.dart';
import 'features/mobile_customer/auth/signup/data_provider/signup_data.dart';
import 'features/mobile_customer/auth/signup/repository/signup_repository.dart';
import 'features/mobile_customer/auth/signup/screens/signup.dart';
import 'features/mobile_customer/booking/bloc/booking_bloc.dart';
import 'features/mobile_customer/booking/data_provider/booking_remote_provider.dart';
import 'features/mobile_customer/booking/repository/booking_repository.dart';
import 'features/mobile_customer/home/data_provider/schedule_remote_provider.dart';
import 'features/mobile_customer/home/repository/schedule_repository.dart';
import 'features/mobile_customer/home/ui/screens/movie_home_screen.dart';
import 'features/mobile_customer/home/ui/screens/scheduled_details_screen.dart';
import 'features/mobile_customer/home/ui/screens/splash_screen.dart';
import 'features/mobile_customer/user/screens/editProfile.dart';
import 'features/mobile_customer/user/screens/profile.dart';

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
        path: '/startup',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child:StartUpScreen(),
          );
        },
        routes: [
          GoRoute(
            name: 'login_customer',
            path: 'Login_customer',
            pageBuilder: (context, state) {

              return MaterialPage(
                key: state.pageKey,
                child:LoginScreen(),
              );
            },
          ),
          GoRoute(
            name: 'login_staff',
            path: 'Login_staff',
            pageBuilder: (context, state) {

              return MaterialPage(
                key: state.pageKey,
                child:IndexScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'Home',
                name: 'home',
                builder: (BuildContext context, GoRouterState state) =>
                //     // loginStorage.getItem('loginData')!=null ? loginStorage.getItem('loginData')==true ?StaffApp() : LoginPage() :LoginPage(),
                StaffApp(),
              ),
              GoRoute(
                path: 'Login',
                name: 'login',
                builder: (BuildContext context, GoRouterState state) =>
                //     // loginStorage.getItem('loginData')!=null ? loginStorage.getItem('loginData')==true ?StaffApp() : LoginPage() :LoginPage(),
                LoginTest(),
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
            ]
          ),
        ]
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
          routes: <GoRoute>[
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
            // GoRoute(
            //   name: 'booking_details',
            //   path: ':booking_id',
            //   pageBuilder: (context, state) {
            //     // final movie = _movieFrom(state.params['id']!);
            //     String booking_id = state.params['booking_id']!;
            //
            //     //movie = bloc.getMovie(id);
            //     return MaterialPage(
            //       key: state.pageKey,
            //       child: BookingDetailsScreen(
            //           booking_id: booking_id
            //       ),
            //     );
            //   },
            // ),
          ]),
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

  final ScheduledBloc scheduledBloc = ScheduledBloc(ScheduledRepository(ScheduledRemoteProvider()));
  final BookingBloc bookingBloc = BookingBloc(BookingRepository(BookingRemoteProvider()));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(LoginRepository(LoginDataProvider()))),
        BlocProvider(create: (_) => SignUpBloc(SignUpRepository(SignUpDataProvider()))),
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
