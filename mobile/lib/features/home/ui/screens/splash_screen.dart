// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/local_data_provider.dart';
import 'package:royal_cinema/core/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  String? finalEmail;

  Future getValidationData() async {
    LocalDbProvider localDbProvider = LocalDbProvider();
    bool isUserLoggedIn = await localDbProvider.isUserLoggedIn();
    if(isUserLoggedIn){
      finalEmail = "The user is logged in";
    }
  }

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 3),
              ()=> finalEmail == null ? GoRouter.of(context).go('/login') : GoRouter.of(context).go('/home')
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Col.background,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}