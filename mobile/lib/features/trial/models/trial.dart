import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Trial{

  final String? id;
  final String fullName;
  final String phone;
  final String passwordHash;
  final double balance;

  Trial({this.id, required this.fullName, required this.phone, required this.passwordHash, required this.balance});

  factory Trial.fromJson(Map<String, dynamic> json) => Trial(
    id: json['id'],
    fullName: json['fullName'],
    phone: json['phone'],
    passwordHash: json['passwordHash'],
    balance: json['balance'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'phone': phone,
    'passwordHash': passwordHash,
    'balance': balance,
  };
}
