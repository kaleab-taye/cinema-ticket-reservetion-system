class Staff {
  final String? id;
  final String phone;
  final String fullName;

  final String passwordHash;
  // final List? booked;
  // final double? balance;

  final String? loginToken;

  Staff(
      {this.id,
      required this.fullName,
      required this.phone,
      required this.passwordHash,
      // this.booked,
      this.loginToken}) {}

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      phone: json['phone'],
      fullName: json['fullName'],
      passwordHash: json['passwordHash'],
      // booked: json['booked'],
      loginToken: json['loginToken'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'fullName': fullName,
        'passwordHash': passwordHash,
        // 'booked': booked,
        'loginToken': loginToken,
      };
}
