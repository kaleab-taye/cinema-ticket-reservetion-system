import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String passwordHash,
    required String booked,
    required double balance,
  }) : super(
    id: id,
    fullName: fullName,
    phoneNumber: phoneNumber,
    passwordHash: passwordHash,
    booked: booked,
    balance: balance,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      passwordHash: json['passwordHash'],
      booked: json['booked'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'passwordHash': passwordHash,
      'booked': booked,
      'balance': balance,
    };
  }

}