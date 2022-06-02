import 'dart:math';

class User {
  late String _id;
  final String fullName;
  final String phone;
  final String passwordHash;
  final List<dynamic> booked;
  final double balance;

  String get id => _id;

  User(
      {required this.fullName,
      required this.phone,
      required this.passwordHash,
      required this.booked,
      required this.balance,
      String? id}) {
    _id = (id ?? Random.secure().nextInt(1000)).toString();
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['fullName'],
    phone: json['phone'],
    passwordHash: json['passwordHash'],
    booked: json['booked'],
    balance: json['balance'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'phone': phone,
    'passwordHash': passwordHash,
    'booked': booked,
    'balance': balance,
  };

}
