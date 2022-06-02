import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Login extends Equatable {
  Login(
      {required this.phone,
        required this.passwordHash,});

  final String phone;
  final String passwordHash;

  @override
  List<Object> get props => [phone, passwordHash];

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      phone: json['phone'],
      passwordHash: json['passwordHash'],
    );
  }
}
