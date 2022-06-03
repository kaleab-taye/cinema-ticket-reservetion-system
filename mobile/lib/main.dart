// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/auth/login/login.dart';
import 'package:royal_cinema/features/auth/signup/bloc/bloc.dart';
import 'package:royal_cinema/features/auth/signup/data_provider/data_provider.dart';
import 'package:royal_cinema/features/auth/signup/repository/repository.dart';
import 'package:royal_cinema/features/auth/signup/screens/screens.dart';
import 'package:royal_cinema/features/home/data_provider/schedule_remote_provider.dart';
import 'package:royal_cinema/features/home/index.dart';
import 'package:royal_cinema/features/home/repository/movie_repository.dart';
import 'package:royal_cinema/features/home/repository/schedule_repository.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_details_screen.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_home_screen.dart';
import 'package:royal_cinema/features/user/bloc/bloc.dart';
import 'package:royal_cinema/features/user/data_provider/user_remote_provider.dart';
import 'package:royal_cinema/features/user/repository/user_repository.dart';

import 'features/auth/login/bloc/auth_bloc.dart';
import 'features/auth/login/screens/login.dart';
import 'features/home/bloc/bloc.dart';
import 'features/user/screens/editProfile.dart';
import 'features/user/screens/profile.dart';

class LoginInfo {
  var isLoggedIn = false;
}

Future<void> main() async {
  final loginInfo = LoginInfo();

  final _router = GoRouter(
    redirect: (state) {
      final loggedIn = loginInfo.isLoggedIn;
    },
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: Profile(),
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
            GoRoute(
              name: 'movie_details',
              path: ':id',
              pageBuilder: (context, state) {
                // final movie = _movieFrom(state.params['id']!);
                String id = state.params['id']!;

                //movie = bloc.getMovie(id);
                return MaterialPage(
                  key: state.pageKey,
                  child: MovieDetailsScreen(
                    id: id,
                  ),
                );
              },
            ),
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

  final MovieBloc movieBloc = MovieBloc(MovieRepository(MovieRemoteProvider()));
  final ScheduledBloc scheduledBloc = ScheduledBloc(ScheduledRepository(ScheduledRemoteProvider()));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(LoginRepository(LoginDataProvider()))),
        BlocProvider(create: (_) => SignUpBloc(SignUpRepository(SignUpDataProvider()))),
        BlocProvider(create: (_) => movieBloc..add(LoadMovies())),
        BlocProvider(create: (_) => scheduledBloc..add(LoadScheduleds())),
        BlocProvider(create: (_) => UserBloc(UserRepository(UserRemoteProvider()))..add(LoadUsers())),
      ],
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

Movie _movieFrom(String s) {

  final List<Movie> movies = [
    Movie(id: "62968871cb506893d53ce76f", title: "title", description: "description", imageUrl: "imageUrl", casts: [], genera: []),
  ];

  return movies.where((coffee) => coffee.id.toString() == s).first;
}
