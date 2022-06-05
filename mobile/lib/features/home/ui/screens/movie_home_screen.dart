// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/booking/screens/booking_screen.dart';
import 'package:royal_cinema/features/home/index.dart';
import 'package:royal_cinema/features/home/ui/screens/scheduled_list_screen.dart';
import 'package:royal_cinema/features/user/bloc/bloc.dart';
import 'package:royal_cinema/features/user/bloc/user_bloc.dart';

import '../../../../core/utils/colors.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({Key? key}) : super(key: key);

  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {

  int currentIndex = 0;
  var screens;

  @override
  void initState() {
    super.initState();
    screens = [
      ScheduledListScreen(),
      BookedListScreen()
      // BookedMovieScreen()
      // MovieListScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Col.background,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Col.secondary,
        elevation: 4.0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              color: Colors.grey,
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
              iconSize: 40,
              onPressed: () {
                final userBloc = BlocProvider.of<UserBloc>(context);
                userBloc.add(LoadUsers());
                GoRouter.of(context).go('/profile');
              },
              icon: Icon(Icons.person)),
        ],
        title: Text(
          "Royal Cinema",
          style: TextStyle(
            color: Col.textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
            letterSpacing: 0.3,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            gradient: LinearGradient(
                colors: [Col.secondary, Col.secondary],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Col.secondary,
        selectedItemColor: Col.primary,
        unselectedItemColor: Colors.white,
        iconSize: 28,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: "Booked",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.schedule),
          //   label: "Schedules",
          // ),
        ],
      ),
    );
  }
}
