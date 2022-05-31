// ignore_for_file: prefer_const_constructors

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/bloc/movie_bloc.dart';
import 'package:royal_cinema/pages/booked.dart';
import 'package:royal_cinema/pages/editProfile.dart';
import 'package:royal_cinema/pages/favourite.dart';
import 'package:royal_cinema/pages/homepage.dart';
import 'package:royal_cinema/pages/login.dart';
import 'package:royal_cinema/pages/profile.dart';
import 'package:royal_cinema/pages/signup.dart';
import 'package:royal_cinema/royal_cinema/presentation/bloc/user_bloc.dart';
import 'package:royal_cinema/royal_cinema/presentation/bloc/user_event.dart';

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()..add(LoadUserCounter())),
        BlocProvider(create: (context) => MovieBloc()..add(LoadMovieCounter())),
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
              child: Login(),
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
          child: SignUp(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: HomePage(),
        ),
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
