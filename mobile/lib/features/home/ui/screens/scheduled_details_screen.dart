// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/home/bloc/bloc.dart';
import 'package:royal_cinema/features/home/model/scheduledMovie.dart';

import '../../../../core/utils/colors.dart';

class ScheduleDetailsScreen extends StatefulWidget {
  ScheduleDetailsScreen({required this.schedule_id}){
    schedule = ScheduledMovie.fromJson(jsonDecode(schedule_id));
  }

  final String schedule_id;
  late ScheduledMovie schedule;

  @override
  _ScheduleDetailsScreen createState() => _ScheduleDetailsScreen();
}

class _ScheduleDetailsScreen extends State<ScheduleDetailsScreen> {

  String? startTime;
  String? endTime;

  @override
  void initState() {
    super.initState();
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(widget.schedule.startTime);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(widget.schedule.endTime);
    String formattedStartTime = DateFormat('h:mma').format(startTime);
    String formattedEndTime = DateFormat('h:mma').format(endTime);

    this.startTime = formattedStartTime;
    this.endTime = formattedEndTime;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Today's",
                    style: TextStyle(
                        color: Col.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$startTime - $endTime",
                    style: TextStyle(
                        color: Col.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.schedule.price} birr",
                    style: TextStyle(
                        color: Col.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20),
              height: 200,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "${ApiData.imageBaseUrl}/${widget.schedule.movie.imageUrl}"),),
                  color: Col.textColor),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                      widget.schedule.movie.title,
                      style: TextStyle(
                        color: Col.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("${widget.schedule.movie.description}", style: TextStyle(
                    color: Col.textColor,
                    fontSize: 18,
                  ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            style: TextStyle(
                              color: Col.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1,
                            ),
                            text: "Stars : "),
                        TextSpan(
                            style: TextStyle(
                              color: Col.textColor,
                              fontSize: 18,
                              letterSpacing: 0.1,
                            ),
                            text: " ${widget.schedule.movie.casts}",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            style: TextStyle(
                              color: Col.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1,
                            ),
                            text: "Genera : "),
                        TextSpan(
                          style: TextStyle(
                            color: Col.textColor,
                            fontSize: 18,
                            letterSpacing: 0.1,
                          ),
                          text: " ${widget.schedule.movie.genera}",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
