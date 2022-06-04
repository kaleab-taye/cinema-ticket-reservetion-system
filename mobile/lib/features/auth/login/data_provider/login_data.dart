import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';

import 'package:royal_cinema/core/local_data_provider.dart';

class LoginDataProvider {

  LoginDataProvider();

  Future loginUser(Login login) async {
    var headersList = {
      'Accept': '*/*',
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


      // print(data["user"]["fullName"]);

      String id = data["user"]["id"].toString();
      String fullName = data["user"]["fullName"].toString();
      String phone = data["user"]["phone"].toString();
      String passwordHash = data["user"]["passwordHash"].toString();
      double balance = double.parse(data["user"]["balance"].toString());
      String loginToken = data["loginToken"].toString();

      // print(resBody);

      // print(loginToken);

      // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.setString("id", id);
      // sharedPreferences.setString("fullName", fullName);
      // sharedPreferences.setString("phone", phone);
      // sharedPreferences.setString("passwordHash", passwordHash);
      // sharedPreferences.setDouble("balance", balance);
      // sharedPreferences.setString("loginToken", loginToken);
      // print(resBody);
      // String full = sharedPreferences.getString("fullName").toString();
      // print("Full Name : $full");
      // return Login.fromJson(jsonDecode(resBody));

      User user = User(fullName: fullName, phone: phone, passwordHash: passwordHash, balance: balance, loginToken: loginToken);
      LocalDbProvider localDbProvider = LocalDbProvider();
      await localDbProvider.addUser(user);

      // print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbb");
      // User userOut = await localDbProvider.getUser();
      // print(userOut.toJson());
      // print(userOut.phone);
    }
    else {
      print(res.reasonPhrase);
      throw Exception('Failed to Login.');
    }
  }
}
