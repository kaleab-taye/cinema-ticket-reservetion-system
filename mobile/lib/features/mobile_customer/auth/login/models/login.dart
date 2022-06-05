import 'dart:math';

class Login {
  final String phone;
  final String passwordHash;

  Login({required this.phone, required this.passwordHash,});

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    phone: json['phone'],
    passwordHash: json['passwordHash'],
  );

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'passwordHash': passwordHash,
  };

}