// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/auth/signup/bloc/bloc.dart';
import 'package:royal_cinema/features/auth/signup/screens/screens.dart';
import 'package:royal_cinema/features/home/index.dart';
import 'package:royal_cinema/features/home/repository/movie_repository.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_details_screen.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_home_screen.dart';

import 'features/auth/login/bloc/auth_bloc.dart';
import 'features/auth/login/screens/login.dart';
import 'features/home/bloc/movie_bloc.dart';
import 'features/user/screens/editProfile.dart';
import 'features/user/screens/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final MovieBloc movieBloc = MovieBloc(MovieRepository(MovieRemoteProvider()));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => SignUpBloc()),
        BlocProvider(create: (_) => movieBloc..add(LoadMovies())),
      ],
      child: MaterialApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
      ),
    );

    // return MaterialApp(
    //   title: 'Royal Cinema',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: Login(),
    // );
  }

  final _router = GoRouter(
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
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Profile(),
        ),
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
      ),
      GoRoute(
        path: '/movie_details',
        pageBuilder: (context, state) {
          final movie = _movieFrom(state.params['id']!);
          return MaterialPage(
            key: state.pageKey,
            child: MovieDetailsScreen(),
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
}

Movie _movieFrom(String s){

  var movies;
  return movies.where((movie) => movie.id == s);
}
