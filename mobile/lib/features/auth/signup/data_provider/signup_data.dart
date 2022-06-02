import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:royal_cinema/features/auth/signup/models/signup.dart';

import '../../../../core/token_data.dart';

class SignUpDataProvider {
  final _baseUrl = 'http://127.0.0.1:5000/${TokenData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';
  final http.Client httpClient;

  SignUpDataProvider({required this.httpClient}) : assert(httpClient != null);

  Future<SignUp> signUpUser(SignUp signUp) async {
    final response = await httpClient.post(
      Uri.http('$_baseUrl', '/users/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'fullName': signUp.fullName,
        'phone': signUp.phone,
        'passwordHash': signUp.passwordHash,
      }),
    );

    if (response.statusCode == 200) {
      return SignUp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create course.');
    }
  }
}
