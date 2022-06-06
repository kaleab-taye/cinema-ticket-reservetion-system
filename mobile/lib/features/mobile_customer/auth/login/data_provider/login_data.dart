import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:royal_cinema/core/customer_core/api_data.dart';
import 'package:royal_cinema/features/mobile_customer/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';

import 'package:royal_cinema/features/mobile_customer/user/data_provider/local_data_provider.dart';

class LoginDataProvider {
  Client client = Client();
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
    // var req = http.Request('POST', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);
    //
    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();
    var res =
    await client.post(url, headers: headersList, body: json.encode(body));
    final resBody = res.body;

    if (res.statusCode >= 200 && res.statusCode < 300) {

      var data = json.decode(resBody);


      // print(data["user"]["fullName"]);

      String id = data["user"]["id"].toString();
      String fullName = data["user"]["fullName"].toString();
      String phone = data["user"]["phone"].toString();
      String passwordHash = data["user"]["passwordHash"].toString();
      int balance = int.parse(data["user"]["balance"].toString());
      String loginToken = data["loginToken"].toString();

      User user = User(id : id, fullName: fullName, phone: phone, passwordHash: passwordHash, balance: balance, loginToken: loginToken);
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
