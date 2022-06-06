import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/mobile_staff/login/bloc/auth_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/login/bloc/auth_event.dart';
import 'package:royal_cinema/features/mobile_staff/login/bloc/auth_state.dart';
import 'package:royal_cinema/features/mobile_staff/login/data_provider/login_data_provider.dart';
import 'package:royal_cinema/features/mobile_staff/login/models/login.dart';
import 'package:royal_cinema/features/mobile_staff/login/repository/login_repository.dart';
import 'package:royal_cinema/core/staff_core/colors.dart';
import 'package:royal_cinema/features/mobile_staff/staff_app.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({Key? key}) : super(key: key);

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  final AuthBloc authBloc = AuthBloc(LoginRepository(LoginDataProvider()));

  @override
  build(BuildContext context) {
    return BlocProvider(
        create: (_) => authBloc,
        child: BlocBuilder<AuthBloc, AuthState>(builder: (_, AuthState state) {
          if (state is LoginSuccessful) {
            return StaffApp();
          }
          // if (state is LoginFailed){

          // }
          else {
            return LoginPage(
              authBloc: authBloc,
              authState: state,
            );
          }
        }));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.authBloc, this.authState})
      : super(key: key);

  final AuthBloc authBloc;
  final AuthState? authState;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  // phoneController.text = ;
  final passwordHashController = TextEditingController();

  Widget showStatusOnButton(state) {
    if (state is LoginSuccessful) {
      return Text("success");
    }
    if (state is LoginFailed) {
      return Text("invalid credentials");
    }
    if (state is LogingIn) {
      return CircularProgressIndicator();
    }

    return Text("Login");
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
                    "STAFF LOGIN",
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
                      controller: phoneController..text = '0987654321',
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
                      controller: passwordHashController..text = 'staff',
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
                  padding: EdgeInsets.fromLTRB(25, 65, 25, 0),
                  child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                          color: Col.primary,
                          child: showStatusOnButton(widget.authState),
                          // Text("Login"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            final formValid = _formKey.currentState!.validate();
                            if (!formValid) return;

                            var bytes =
                                utf8.encode(passwordHashController.text);
                            var sha512 = sha256.convert(bytes);
                            var hashedPassword = sha512.toString();

                            var resp = await widget.authBloc..add(LoginAuth(Login(phone: phoneController.text, passwordHash: hashedPassword)));
                            print(resp.state);
                          })),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                //   child: Container(
                //     width: double.infinity,
                //     child: TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         "login as a User",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
