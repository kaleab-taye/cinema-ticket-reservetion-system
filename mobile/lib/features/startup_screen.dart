// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/customer_core/utils/colors.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Col.background,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            children: [
              SizedBox(height: 120,),
              Text(
                "ROYAL",
                style: TextStyle(
                  color: Col.primary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                "CINEMA",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 120,),
              Text(
                "ENTER AS A : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  RaisedButton(
                    color: Col.textColor,
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text(
                      "User",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        letterSpacing: 0.3,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        ),
                    onPressed: () {
                      context.goNamed('login_customer');
                    },
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(
                    color: Col.textColor,
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text(
                      "Staff",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        letterSpacing: 0.3,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        ),
                    onPressed: () {
                      context.goNamed('login_staff');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
