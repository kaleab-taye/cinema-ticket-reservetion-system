import 'package:sec_2/admin_features/user/models/staff.dart';

class LoginResponse {
  final Staff staff;
  final String loginToken;

  LoginResponse({required this.staff, required this.loginToken}) {}

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      staff: Staff.fromJson(json['staff']),
      loginToken: json['loginToken'],
    );
  }

  Map<String, dynamic> toJson() => {
        'staff': staff,
        'loginToken': loginToken,
      };
}
