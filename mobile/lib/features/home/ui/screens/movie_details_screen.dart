// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/home/bloc/bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../model/movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({required this.id}){
    movie = Movie.fromJson(jsonDecode(id));
  }

  final String id;
  late Movie movie;

  @override
  _MovieDetailsScreen createState() => _MovieDetailsScreen();
}

class _MovieDetailsScreen extends State<MovieDetailsScreen> {

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
            GoRouter.of(context).go("/home");
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 20),
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "${ApiData.baseUrl}/${widget.movie.imageUrl}"),),
                  color: Col.textColor),
              ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26, width: 1),
                color: Col.background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.movie.title,
                      style: TextStyle(
                        color: Col.primary,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Description : ${widget.movie.description}", style: TextStyle(
                    color: Col.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text("Casts : ${widget.movie.casts}", style: TextStyle(
                    color: Col.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text("Genera : ${widget.movie.genera}", style: TextStyle(
                    color: Col.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1,
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
