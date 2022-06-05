// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/local_data_provider.dart';
import 'package:royal_cinema/features/auth/login/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/colors.dart';
import '../models/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordHashController = TextEditingController();
@override
void initState(){
  super.initState();
  phoneController.text = "0987654321";
  passwordHashController.text = "client";
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Col.background,
      body: SingleChildScrollView(
        child: Container(
          color: Col.background,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: Text(
                    "ROYAL",
                    style: TextStyle(
                      color: Col.primary,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "CINEMA",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 65, 0, 0),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Col.textColor,
                      fontSize: 35,
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
                      controller: phoneController,
                      // onChanged: (value) {
                      //   phoneController.text = value;
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can not be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "",
                        hintStyle: TextStyle(
                          color: Col.textColor,
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.1,
                        ),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          color: Col.textColor,
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          letterSpacing: 0,
                        ),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
                  child: Container(

                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: passwordHashController,
                      // onChanged: (value) {
                      //   passwordHashController.text = value;
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can not be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Col.textColor,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            letterSpacing: 0.1,
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Col.textColor,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            letterSpacing: 0,
                          ),
                          border: OutlineInputBorder(),
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
                          )),
                      obscureText: _secureText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 25),
                  child: Center(child: Text("*For demo purpose, we have set the values to the default client.", style: TextStyle(
                    color: Colors.white,
                  ),)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 65, 25, 0),
                  child: Container(
                    width: double.infinity,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listenWhen: (previous, current) {
                        return current is LoginSuccessful;
                      },
                      listener: (_, AuthState state) {
                        GoRouter.of(context).go('/home');
                      },
                      builder: (_, AuthState state) {
                        Widget buttonChild = Text(
                          "Login",
                          style: TextStyle(
                            color: Col.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            letterSpacing: 0.3,
                          ),
                        );
                        return RaisedButton(
                            color: Col.primary,
                            child: buttonChild,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState!.validate();
                              if (!formValid) return;

                              var bytes = utf8.encode(passwordHashController.text);
                              var sha512 = sha256.convert(bytes);
                              var hashedPassword = sha512.toString();

                              final authBloc = BlocProvider.of<AuthBloc>(context);
                              authBloc.add(LoginAuth(
                                  Login(phone: phoneController.text, passwordHash: hashedPassword)));
                            });
                      },
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                //   child: Container(
                //     width: double.infinity,
                //     child: TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         "Forgot password",
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Nunito',
                //           letterSpacing: 0.3,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                style: TextStyle(
                                  color: Col.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.3,
                                ),
                                text: "Don’t have an account?"),
                            TextSpan(
                                style: TextStyle(
                                  color: Col.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.3,
                                ),
                                text: " SignUp",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    GoRouter.of(context).go('/signup');
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
