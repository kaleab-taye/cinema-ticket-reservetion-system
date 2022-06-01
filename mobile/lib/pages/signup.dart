// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/constants/colors.dart';
import 'package:royal_cinema/pages/homepage.dart';
import 'package:royal_cinema/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
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
                        // controller: TextEditingController(text: user.fullName),
                        onChanged: (value){
                        },
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
                        // controller: TextEditingController(text: user.email),
                        onChanged: (value){
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can not be empty";
                          } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return "Please enter valid email";
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
                          labelText: "Email",
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
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  // (signUpresponse == "INVALID_CALL:|:USER_EMAIL_ALREADY_IN_USE")
                  //     ? Padding(
                  //   padding: const EdgeInsets.only(top: 5, left: 25),
                  //   child: Text(
                  //     "Email already in use",
                  //     style: TextStyle(
                  //         color: Colors.redAccent,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15),
                  //   ),
                  // )
                  //     : Text(""),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        // controller: TextEditingController(text: user.phone),
                        onChanged: (value){
                          // user.phone = value;
                        },
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
                  // (signUpresponse == "INVALID_CALL:|:USER_PHONE_ALREADY_IN_USE")
                  //     ? Padding(
                  //   padding: const EdgeInsets.only(top: 5, left: 25),
                  //   child: Text(
                  //     "Phone number already in use",
                  //     style: TextStyle(
                  //         color: Colors.redAccent,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15),
                  //   ),
                  // )
                  //     : Text(""),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        // controller: TextEditingController(text: user.defaultPlateNumber),
                        onChanged: (value){
                          // user.defaultPlateNumber = value;
                        },
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
                          labelText: "Plate Number",
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
                        // controller: TextEditingController(text: user.passwordHash),
                        onChanged: (value){
                          // var bytes = utf8.encode(value);
                          // var sha512 = sha256.convert(bytes);
                          // var hashedPassword = sha512.toString();
                          // this.hashedPassword = hashedPassword;
                          // user.passwordHash = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can not be empty";
                          } else if (value.length <= 6) {
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
                                color: Col.background,
                              ),
                            )),
                        obscureText: _secureText,
                      ),
                    ),
                  ),
                  // isProcessing
                  //     ? Padding(
                  //   padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  //   child: Center(
                  //     child: CircularProgressIndicator(
                  //       color: Col.primary,
                  //       strokeWidth: 2,
                  //     ),
                  //   ),
                  // )
                  //     : isDataEntered
                  //     ? Padding(
                  //   padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         "Verification code has been sent to your email",
                  //         style: TextStyle(
                  //           color: Col.background,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'Nunito',
                  //           letterSpacing: 0.1,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Container(
                  //         alignment: Alignment.center,
                  //         child: TextFormField(
                  //           validator: (value) {
                  //             if (value!.isEmpty) {
                  //               return "This field can not be empty";
                  //             }else if(value != verificationCode){
                  //               return "Please enter the correct verification code";
                  //             }
                  //             return null;
                  //           },
                  //           decoration: InputDecoration(
                  //             hintText: "",
                  //             hintStyle: TextStyle(
                  //               color: Col.textColor,
                  //               fontSize: 14,
                  //               fontFamily: 'Nunito',
                  //               letterSpacing: 0.1,
                  //             ),
                  //             labelText: "Verification Code",
                  //             labelStyle: TextStyle(
                  //               color: Col.textColor,
                  //               fontSize: 14,
                  //               fontFamily: 'Nunito',
                  //               letterSpacing: 0,
                  //             ),
                  //             border: OutlineInputBorder(),
                  //             errorBorder: OutlineInputBorder(
                  //               borderSide:
                  //               BorderSide(color: Colors.red),
                  //             ),
                  //           ),
                  //           keyboardType: TextInputType.number,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                  //     : Text(""),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Col.primary,
                        child: Text(
                          // isDataEntered ? "Verify" :
                              "Register",
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
                            GoRouter.of(context).go('/home');
                            }
                          else {
                            print("Enter fields");
                          }
                        },
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
                                      GoRouter.of(context).go('/');
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
