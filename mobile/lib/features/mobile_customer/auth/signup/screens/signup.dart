// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/mobile_customer/auth/login/bloc/bloc.dart';
import 'package:royal_cinema/features/mobile_customer/auth/login/models/login.dart';
import 'package:royal_cinema/features/mobile_customer/auth/signup/bloc/bloc.dart';
import 'package:royal_cinema/features/mobile_customer/auth/signup/models/models.dart';

import '../../../../../core/customer_core/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final signupformKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordHashController = TextEditingController();
  final fullNameController = TextEditingController();
  bool _secureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Col.background,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
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
          Container(
            color: Col.background,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 40, 0, 0),
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(
                        color: Col.textColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: fullNameController,
                        // onChanged: (value) {
                        //   fullNameController.text = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can not be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(
                            color: Col.textColor,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            letterSpacing: 0.1,
                          ),
                          labelText: "Full Name",
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
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: phoneController,
                        // onChanged: (value) {
                        //   // user.phone = value;
                        //   phoneController.text = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can not be empty";
                          }
                          return null;
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
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: passwordHashController,
                        // onChanged: (value) {
                        //   // var bytes = utf8.encode(value);
                        //   // var sha512 = sha256.convert(bytes);
                        //   // var hashedPassword = sha512.toString();
                        //   passwordHashController.text = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can not be empty";
                          } else if (value.length < 6) {
                            return "Password should be at least 6 characters";
                          }
                          return null;
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
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
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
                            )),
                        obscureText: _secureText,
                      ),
                    ),
                  ),
                  Form(
                    key: signupformKey,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
                      child: Container(
                        width: double.infinity,
                        child: BlocConsumer<SignUpBloc, SignUpState>(
                          listenWhen: (previous, current) {
                            return current is SignUpSuccessful;
                          },
                          listener: (_, SignUpState state) {},
                          builder: (_, SignUpState state) {
                            Widget buttonChild = RaisedButton(
                              color: Col.primary,
                              padding: EdgeInsets.symmetric(horizontal: 120),
                              child: Text("Signup",
                                style: TextStyle(
                                  color: Col.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.3,
                                ),),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              onPressed: () {
                                final formValid =
                                    _formKey.currentState!.validate();
                                if (!formValid) return;

                                var bytes = utf8.encode(passwordHashController.text);
                                var sha512 = sha256.convert(bytes);
                                var hashedPassword = sha512.toString();

                                final verifyBloc =
                                    BlocProvider.of<SignUpBloc>(context);
                                verifyBloc.add(SignUpVerify(SignUp(
                                    fullName: fullNameController.text,
                                    phone: phoneController.text,
                                    passwordHash: hashedPassword)));
                              },
                            );

                            Widget verifyChecker = Text("");

                            if (state is OnLoadingSignUpVerifySuccessful) {
                              verifyChecker = Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            Widget isSignupSuccessful = Text("");

                            if (state is SignUpVerifySuccessful) {
                              verifyChecker = Column(
                                children: [
                                  Text(
                                    "Phone verification code has been sent to your phone : ",
                                    style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    onChanged: (value) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "This field can not be empty";
                                      } else if (value != "12345") {
                                        return "Please enter the correct verification code";
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
                                      labelText: "Verification Code",
                                      labelStyle: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        letterSpacing: 0,
                                      ),
                                      border: OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  Text(
                                    "*for demo purpose the verification code is 12345",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  SizedBox(height: 20,)
                                ],
                              );

                              buttonChild = BlocConsumer<AuthBloc, AuthState>(
                                listenWhen: (previous, current) {
                                  return current is LoginSuccessful;
                                },
                                listener: (_, AuthState state) {
                                  GoRouter.of(context).go('/home');
                                },
                                builder: (_, AuthState state) {
                                  return RaisedButton(
                                    padding: EdgeInsets.symmetric(horizontal: 120),
                                    color: Col.primary,
                                    child: Text("Verify",
                                      style: TextStyle(
                                        color: Col.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        letterSpacing: 0.3,
                                      ),),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    onPressed: () {
                                      if (signupformKey.currentState!
                                          .validate()) {

                                        var bytes = utf8.encode(passwordHashController.text);
                                        var sha512 = sha256.convert(bytes);
                                        var hashedPassword = sha512.toString();

                                        final authBloc = BlocProvider.of<SignUpBloc>(context);
                                        authBloc.add(SignUpAuth(SignUp(fullName: fullNameController.text, phone: phoneController.text, passwordHash: hashedPassword)));

                                        GoRouter.of(context).go('/home');
                                      }
                                    },
                                  );
                                },
                              );
                            }

                            if (state is SignUpVerifyFailed) {
                              verifyChecker = Text(
                                "SignUp Failed",
                                style: TextStyle(
                                  color: Col.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.3,
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Container(
                                  child: verifyChecker,
                                ),
                                buttonChild
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
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
                                  text: "Already have an account?"),
                              TextSpan(
                                  style: TextStyle(
                                    color: Col.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    letterSpacing: 0.3,
                                  ),
                                  text: " Login",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.goNamed('login_customer');
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
        ],
      ),
    );
  }
}
