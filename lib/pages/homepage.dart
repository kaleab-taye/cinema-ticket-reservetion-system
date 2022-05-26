// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:royal_cinema/constants/colors.dart';
import 'package:royal_cinema/pages/booked.dart';
import 'package:royal_cinema/pages/favourite.dart';
import 'package:royal_cinema/pages/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  var screens;

  @override
  void initState() {
    super.initState();
    screens = [
      Home(),
      Booked(),
      Favourite()
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
              },
              icon: Icon(Icons.account_circle_sharp)),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
        ],
      ),
    );
  }
}
