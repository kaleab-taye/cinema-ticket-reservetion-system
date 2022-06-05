
import 'package:sec_2/admin_features/user/models/user.dart';

class LoggedInUser {


  final User user;
  final String loginToken;

  LoggedInUser(
      {
        
      required this.user,
      required this.loginToken
      
      }) {}

  factory LoggedInUser.fromJson(Map<String, dynamic> json) {
    return LoggedInUser(
      user: User.fromJson(json['user']),
      loginToken: json['loginToken'],
      // fullName: json['fullName'],
      // passwordHash: json['passwordHash'],
      // balance: json["balance"],
    );
  }

  Map<String, dynamic> toJson() => {

        "loginToken": loginToken,
        "user": user.toJson(),
      };
}
