// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/local_data_provider.dart';
import 'package:royal_cinema/core/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/bloc.dart';
import '../model/user.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {

  @override
  void initState() {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(LoadUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Col.background,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 4.0,
        toolbarHeight: 70,
        leading: IconButton(
          color: Col.background,
          onPressed: () {
            GoRouter.of(context).go('/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Col.textColor,
          ),
        ),
        actions: [
          IconButton(
              color: Col.textColor,
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
              iconSize: 40,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "ROYAL CINEMA",
                          style: TextStyle(
                            color: Col.textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            letterSpacing: 0.3,
                          ),
                        ),
                        content: Text(
                          "Do you want to Log out ?",
                          style: TextStyle(
                            color: Col.textColor,
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            letterSpacing: 0.3,
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              // sharedPreferences.remove("fullName");
                              LocalDbProvider localDbProvider =
                                  LocalDbProvider();
                              await localDbProvider.deleteUsers();

                              GoRouter.of(context).go('/login');
                            },
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                        elevation: 10.0,
                      );
                    });
              },
              icon: Icon(Icons.logout)),
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
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (p, c) => c is! UserUpdateSuccessful,
          builder: (_, UserState state) {
            if (state is UsersLoadingFailed) {
              return Center(
                child: Text("Fetching User Failed"),
              );
            }

            if (state is UsersLoaded) {
              return Container(
                color: Col.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
                      child: Text(
                        "Full Name",
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        // sharedPreferences.getString("fullName").toString(),
                        state.user.fullName,
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Divider(
                      color: Col.textColor,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                      child: Text(
                        "Phone",
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        state.user.phone,
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Divider(
                      color: Col.textColor,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                      child: Text(
                        "Balance",
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        state.user.balance.toString(),
                        style: TextStyle(
                          color: Col.textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Divider(
                      color: Col.textColor,
                    ),
                  ],
                ),
              );
            }

            final userBloc = BlocProvider.of<UserBloc>(context);
            userBloc.add(LoadUsers());

            return SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go('/editProfile');
        },
        backgroundColor: Col.textColor,
        child: Icon(
          Icons.edit,
          color: Col.background,
        ),
      ),
    );
  }
}
