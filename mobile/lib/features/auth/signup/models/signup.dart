import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class SignUp extends Equatable {
  SignUp(
      {required this.fullName, required this.phone, required this.passwordHash});

  final String fullName;
  final String phone;
  final String passwordHash;

  @override
  List<Object> get props => [fullName, phone, passwordHash];

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      fullName: json['fullName'],
      phone: json['phone'],
      passwordHash: json['passwordHash'],
    );
  }
}
