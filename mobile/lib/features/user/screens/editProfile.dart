// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

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
          color: Col.textColor,
          onPressed: () {
            GoRouter.of(context).go('/profile');
          },
          icon: Icon(Icons.arrow_back),
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
              child: Container(
                color: Col.background,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
                        child: Text(
                          "Edit Profile",
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
                        padding: EdgeInsets.fromLTRB(25, 60, 25, 0),
                        child: Container(
                          alignment: Alignment.center,
                          child: TextFormField(
                            // controller: TextEditingController(text: fullName),
                            onChanged: (value) {
                              // fullName = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field can not be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "jhjhj",
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                                color: Col.textColor,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // hintText: fullName,
                              // hintStyle: TextStyle(
                              //   fontSize: 21,
                              //   fontFamily: "Nunito",
                              //   letterSpacing: 0.1,
                              //   color: Col.Onbackground,
                              // )
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
                        child: Container(
                          alignment: Alignment.center,
                          child: TextFormField(
                            // controller: TextEditingController(text: phone),
                            onChanged: (value) {
                              // phone = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field can not be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                                color: Col.textColor,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // hintText: phone,
                              // hintStyle: TextStyle(
                              //   fontSize: 21,
                              //   fontFamily: "Nunito",
                              //   letterSpacing: 0.1,
                              //   color: Col.Onbackground,
                              // )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        backgroundColor: Col.textColor,
        child: Icon(
          Icons.check,
          color: Col.background,
        ),
      ),
    );
  }
}
