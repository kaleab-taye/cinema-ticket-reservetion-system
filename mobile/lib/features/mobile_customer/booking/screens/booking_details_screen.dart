// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:royal_cinema/core/customer_core/api_data.dart';

import '../../../../core/customer_core/utils/colors.dart';
import '../model/booking.dart';

class BookingDetailsScreen extends StatefulWidget {
  BookingDetailsScreen({required this.booking_id}){
    booking = BookingMovie.fromJson(jsonDecode(booking_id));
  }

  final String booking_id;
  late BookingMovie booking;

  @override
  _BookingDetailsScreen createState() => _BookingDetailsScreen();
}

class _BookingDetailsScreen extends State<BookingDetailsScreen> {

  String? startTime;
  String? endTime;

  @override
  void initState() {
    super.initState();
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(widget.booking.schedule.startTime);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(widget.booking.schedule.endTime);
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
                    "${widget.booking.schedule.price} birr",
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
                        "${ApiData.imageBaseUrl}/${widget.booking.schedule.movie.imageUrl}"),),
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
                      widget.booking.schedule.movie.title,
                      style: TextStyle(
                        color: Col.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("${widget.booking.schedule.movie.description}", style: TextStyle(
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
                          text: " ${widget.booking.schedule.movie.casts}",
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
                          text: " ${widget.booking.schedule.movie.genera}",
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
