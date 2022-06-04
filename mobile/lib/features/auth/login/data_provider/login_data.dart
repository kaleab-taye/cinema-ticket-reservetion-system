import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:royal_cinema/core/api_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';

class LoginDataProvider {

  LoginDataProvider();

  Future loginUser(Login login) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/users/login');

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

      var data = json.decode(resBody);
      String id = data["id"].toString();
      String fullName = data["fullName"].toString();
      String phone = data["phone"].toString();
      String passwordHash = data["passwordHash"].toString();
      // String balance = data["balance"];
      String loginToken = data["loginToken"].toString();

      print(data);

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("id", id);
      sharedPreferences.setString("fullName", fullName);
      sharedPreferences.setString("phone", phone);
      sharedPreferences.setString("passwordHash", passwordHash);
      // sharedPreferences.setString("balance", balance);
      sharedPreferences.setString("loginToken", loginToken);
      print(resBody);
      String full = sharedPreferences.getString("fullName").toString();
      print("Full Name : $full");
      // return Login.fromJson(jsonDecode(resBody));
    }
    else {
      print(res.reasonPhrase);
      throw Exception('Failed to Login.');
    }
  }
}
