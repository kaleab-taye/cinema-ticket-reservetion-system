// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/constants/colors.dart';
import 'package:royal_cinema/pages/editProfile.dart';
import 'package:royal_cinema/pages/login.dart';
import '../royal_cinema/presentation/bloc/bloc.dart';

import '../royal_cinema/domain/entities/user.dart';
import 'homepage.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
          icon: Icon(Icons.arrow_back, color: Col.textColor,),
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
                              GoRouter.of(context).go('/');
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
                              GoRouter.of(context).go('/');
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
          builder: (context, state) {
            if(state is UserInitial) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: const CircularProgressIndicator(color: Colors.orange,)));
            }
            if(state is UserLoaded){
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
                        "hghg",
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
                        "Beka Dessalegn",
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
                        "Email",
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
                        "bekadessalegn@gmail.com",
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
                        "Phone Number",
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
                        "+251978061901",
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
            else{
              return const Text("Something went wrong");
            }
          },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserBloc>().add(AddUser(User.users[0]));
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
