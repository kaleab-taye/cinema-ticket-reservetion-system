// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String passwordHash;
  final String booked;
  final double balance;

  const User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.passwordHash,
    required this.booked,
    required this.balance,
});

  @override
  List<Object?> get props => [id, fullName, phoneNumber, passwordHash, booked, balance];

  static List<User> users = [
    User(id: "12356", fullName: "Kaleab Taye", phoneNumber: "+251978061901", passwordHash: "asdfghjk", booked: "", balance: 20.0),
    User(id: "12", fullName: "Kaleab Taye", phoneNumber: "+251978061901", passwordHash: "asdfghjk", booked: "", balance: 20.0),
    User(id: "1547", fullName: "Estfianos Neway", phoneNumber: "+251978061901", passwordHash: "asdfghjk", booked: "", balance: 20.0),
    User(id: "15963", fullName: "Nebichaw Jah", phoneNumber: "+251978061901", passwordHash: "asdfghjk", booked: "", balance: 20.0),
    User(id: "154872", fullName: "Lidya Denqwar", phoneNumber: "+251978061901", passwordHash: "asdfghjk", booked: "", balance: 20.0),
  ];
}