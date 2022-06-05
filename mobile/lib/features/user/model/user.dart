import 'dart:math';

class User {
  String? id;
  final String fullName;
  final String phone;
  final String passwordHash;
  final int balance;
  String? loginToken;

  // String get id => _id;

  User(
      {
        this.id,
        required this.fullName,
      required this.phone,
      required this.passwordHash,
      required this.balance,
      this.loginToken,});
  // {
  //   _id = (id ?? Random.secure().nextInt(1000)).toString();
  // }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['fullName'],
    phone: json['phone'],
    passwordHash: json['passwordHash'],
    balance: json['balance'],
    loginToken: json['loginToken'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'phone': phone,
    'passwordHash': passwordHash,
    'balance': balance,
    'loginToken': loginToken,
  };

}
