// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/colors.dart';
import '../../model/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  MovieDetailsScreen({Key? key}) : super(key: key) {
    title = movie.title;
    description = movie.description;
    imageUrl = movie.imageUrl;
    casts = movie.casts;
    genera = movie.genera;
  }

  late final Movie movie;
  late String title, description, imageUrl;
  late List<dynamic> casts;
  late List<dynamic> genera;

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
        leading: IconButton(
          color: Col.background,
          onPressed: () {
            GoRouter.of(context).go('/home');
          },
          icon: Icon(Icons.arrow_back, color: Col.textColor,),
        ),
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width - 40,
          color: Colors.grey,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 300,
                margin: EdgeInsets.only(right: 5, left: 5),
                color: Colors.orange,
              ),
              Expanded(child: Container(
                height: 500,
                color: Colors.green,
                child: Column(
                  children: [
                    Text("", style: TextStyle(
                      color: Col.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
