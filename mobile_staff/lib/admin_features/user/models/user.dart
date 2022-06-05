class User {
  final String? id;
  final String phone;
  final String fullName;
  final String passwordHash;
  final int? balance;

  User(
      {this.id,
      required this.fullName,
      required this.phone,
      required this.passwordHash,
      this.balance}) {}

  factory User.fromJson(Map<String, dynamic> json) {
    
    return User(
      id: json['id'],
      phone: json['phone'],
      fullName: json['fullName'],
      passwordHash: json['passwordHash'],
      balance: json["balance"],
    );
     
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "fullName": fullName,
        "passwordHash": passwordHash,
        "balance": balance
      };
}
