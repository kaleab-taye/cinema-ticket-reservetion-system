// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/bloc/movie_bloc.dart';
import 'package:royal_cinema/constants/colors.dart';
import 'package:royal_cinema/pages/home.dart';
import 'package:royal_cinema/pages/homepage.dart';
import 'package:royal_cinema/pages/signup.dart';

import '../royal_cinema/domain/entities/movie.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Col.background,
      body: SingleChildScrollView(
        child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
      if(state is MovieInitial) {
        return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(child: const CircularProgressIndicator(color: Colors.orange,)));
      }
      if(state is MovieLoaded){
        return Container(
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
                      // controller: TextEditingController(text: user.phone),
                      onChanged: (value) {},
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
                      // controller: TextEditingController(text: user.passwordHash),
                      onChanged: (value) {},
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
                              color: Col.background,
                            ),
                          )),
                      obscureText: _secureText,
                    ),
                  ),
                ),
                // (response == "Not Found")
                //     ? Padding(
                //         padding: const EdgeInsets.only(top: 15, left: 25),
                //         child: Text(
                //           "One of the credentials is incorrect",
                //           style: TextStyle(
                //               color: Colors.redAccent,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 15),
                //         ),
                //       )
                //     : Text(""),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 65, 25, 0),
                  child: Container(
                    width: double.infinity,
                    child: RaisedButton(
                        color: Col.primary,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Col.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            letterSpacing: 0.3,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<MovieBloc>().add(AddMovie(Movie.movies[0]));
                            GoRouter.of(context).go('/home');
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
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
        );
          }
          else{
          return const Text("Something went wrong");
          }
        },

        ),
      ),
    );
  }
}
