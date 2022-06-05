// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/utils/colors.dart';
import 'package:royal_cinema/features/user/bloc/bloc.dart';

import '../bloc/user_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  late String fullName, phone,password,passwordHash;
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
        child: BlocBuilder<UserBloc, UserState>(
              buildWhen: (p, c) => c is! UserUpdateSuccessful,
              builder: (_, UserState state) {
                if (state is UsersLoadingFailed) {
                  return Center(
                    child: Text("Fetching User Failed"),
                  );
                }

                if (state is UsersLoaded) {

                  fullName = state.user.fullName;
                  phone = state.user.phone;
                  passwordHash = state.user.passwordHash;
                  password = "";

                  return Container(
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
                                controller: TextEditingController(text: state.user.fullName),
                                onChanged: (value) {
                                  fullName = value;
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
                                  labelText: "Full Name",
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3,
                                    color: Col.textColor,
                                  ),
                                  fillColor: Colors.white,
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
                                controller: TextEditingController(text: state.user.phone),
                                onChanged: (value) {
                                  phone = value;
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
                                    fontSize: 20,
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
                            child: Container(
                              alignment: Alignment.center,
                              child: TextFormField(
                                // controller: TextEditingController(text: password),
                                onChanged: (value) {
                                  password = value;
                                },
                                validator: (value) {
                                  if (value!.length>0 && value.length < 6) {
                                    return "Password should be at least 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3,
                                    color: Col.textColor,
                                  ),
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,

                                  hintText: "unchanged",
                                  hintStyle: TextStyle(
                                    fontFamily: "Nunito",
                                    color: Col.textColor,
                                  ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _secureText = !_secureText;
                                        });
                                      },
                                      icon: Icon(
                                        _secureText == true
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Col.textColor,
                                      ),
                                    ),),
                                obscureText: _secureText,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: RaisedButton(
                              color: Col.primary,
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  final userBloc = BlocProvider.of<UserBloc>(context);
                                  if(password == ""){
                                    password = passwordHash;
                                  } else{
                                    var bytes = utf8.encode(password);
                                    var sha512 = sha256.convert(bytes);
                                    password = sha512.toString();
                                  }
                                  userBloc.add(EditUser(fullName, phone, password));
                                  GoRouter.of(context).go("/profile");
                                }
                              },
                              // backgroundColor: Col.textColor,
                              child: Text(
                                "Save"
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final userBloc = BlocProvider.of<UserBloc>(context);
                userBloc.add(LoadUsers());

                return SizedBox();
              },
            ),
      ),
      // floatingActionButton: Form(
        // key: _formKey,
        // child: FloatingActionButton(
        //   onPressed: (){
        //     final userBloc = BlocProvider.of<UserBloc>(context);
        //     if(password == ""){
        //       password = passwordHash;
        //     } else{
        //       var bytes = utf8.encode(password);
        //       var sha512 = sha256.convert(bytes);
        //       password = sha512.toString();
        //     }
        //     userBloc.add(EditUser(fullName, phone));
        //     GoRouter.of(context).go("/profile");
        //   },
        //   backgroundColor: Col.textColor,
        //   child: Icon(
        //     Icons.check,
        //     color: Col.background,
        //   ),
        // ),
      // ),
    );
  }
}
