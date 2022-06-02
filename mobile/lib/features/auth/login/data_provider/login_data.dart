import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../../core/token_data.dart';
import '../models/login.dart';

class LoginDataProvider {
  final _baseUrl = 'http://127.0.0.1:5000/${TokenData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';

  LoginDataProvider();

  Future<Login> loginUser(Login login) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/users/login');

    var body = {
      "phone": login.phone,
      "passwordHash": login.passwordHash
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      return Login.fromJson(jsonDecode(resBody));
    }
    else {
      print(res.reasonPhrase);
      throw Exception('Failed to Login.');
    }
  }
}
