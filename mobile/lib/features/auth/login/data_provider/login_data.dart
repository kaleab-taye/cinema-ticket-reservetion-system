import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../../core/token_data.dart';
import '../models/login.dart';

class LoginDataProvider {
  final _baseUrl = 'http://127.0.0.1:5000/${TokenData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';
  final http.Client httpClient;

  LoginDataProvider({required this.httpClient}) : assert(httpClient != null);

  Future<Login> loginUser(Login login) async {
    final response = await httpClient.post(
      Uri.http('$_baseUrl', '/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phone': login.phone,
        'passwordHash': login.passwordHash,
      }),
    );

    if (response.statusCode == 200) {
      return Login.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create course.');
    }
  }
}
