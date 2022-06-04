class Staff {
  final String? id;
  final String phone;
  final String fullName;

  final String passwordHash;
  final List? booked;
  final double? balance;


  Staff({this.id,required this.fullName,required this.phone,required this.passwordHash, this.booked,this.balance}) {
  }

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      phone: json['phone'],
      fullName: json['fullName'],
      passwordHash: json['passwordHash'],
      booked: json['booked'],
      balance: json['balance'],
    );
  }
}
