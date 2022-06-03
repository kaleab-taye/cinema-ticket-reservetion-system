import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:royal_cinema/features/auth/signup/models/signup.dart';

import '../../../../core/token_data.dart';

class SignUpDataProvider {
  final _baseUrl = 'http://127.0.0.1:5000/${TokenData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';

  SignUpDataProvider();

  Future signUpUser(SignUp signUp) async {
    var headersList = {
      'Accept': '*/*',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$_baseUrl/users');

    var body = {
      "fullName": signUp.fullName,
      "phone": signUp.phone,
      "passwordHash": signUp.passwordHash
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
      throw Exception('Failed to SignUp.');
    }
  }
}
