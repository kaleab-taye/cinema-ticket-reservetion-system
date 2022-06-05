import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sec_2/admin_features/login/bloc/auth_bloc.dart';
import 'package:sec_2/admin_features/login/bloc/auth_event.dart';
import 'package:sec_2/admin_features/login/bloc/auth_state.dart';
import 'package:sec_2/admin_features/login/data_provider/login_data_provider.dart';
import 'package:sec_2/admin_features/login/models/login.dart';
import 'package:sec_2/admin_features/login/repository/login_repository.dart';
import 'package:sec_2/core/colors.dart';
import 'package:sec_2/staff_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  // phoneController.text = ;
  final passwordHashController = TextEditingController();

  final AuthBloc authBloc = AuthBloc(LoginRepository(LoginDataProvider()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => authBloc,
        child: Scaffold(
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
                        child: BlocBuilder<AuthBloc, AuthState>(
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
                            print(state);
                            if (state is LogingIn) {
                              buttonChild = SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }

                            if (state is LoginSuccessful) {
                              print("login success heard");
                              buttonChild = Text(
                                "Login successful",
                                style: TextStyle(
                                  color: Col.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.3,
                                ),
                              );

                              // StaffApp();
                              // context.goNamed('home');
                              context.go('/');
                            }

                            if (state is LoginFailed) {
                              buttonChild = Text(
                                "Invalid Credentials",
                                style: TextStyle(
                                  color: Col.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.3,
                                ),
                              );
                            }
                            return RaisedButton(
                                color: Col.primary,
                                child: buttonChild,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () async {
                                  final formValid =
                                      _formKey.currentState!.validate();
                                  if (!formValid) return;

                                  var bytes =
                                      utf8.encode(passwordHashController.text);
                                  var sha512 = sha256.convert(bytes);
                                  var hashedPassword = sha512.toString();

                                  var resp = await authBloc
                                    ..add(LoginAuth(Login(
                                        phone: phoneController.text,
                                        passwordHash: hashedPassword)));
                                  print('res');
                                  print(resp.state);
                                  print('res');
                                  // while (state is Idle || state is LogingIn || state is LoginSuccessful) {
                                  // if (state is LoginSuccessful){

                                  //   return context.goNamed('staff');
                                  // }

                                  // }

                                  // while (resp.state is not )
                                });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "login as a User",
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
