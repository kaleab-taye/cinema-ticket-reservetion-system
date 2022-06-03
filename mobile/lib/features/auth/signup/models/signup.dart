import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUp{

  final String fullName;
  final String phone;
  final String passwordHash;

  SignUp({required this.fullName, required this.phone, required this.passwordHash});

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
    fullName: json['fullName'],
    phone: json['phone'],
    passwordHash: json['passwordHash'],
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'phone': phone,
    'passwordHash': passwordHash,
  };
}
