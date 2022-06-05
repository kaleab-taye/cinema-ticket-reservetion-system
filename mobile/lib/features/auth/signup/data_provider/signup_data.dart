import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/auth/login/data_provider/login_data.dart';
import 'package:royal_cinema/features/auth/login/models/login.dart';
import 'package:royal_cinema/features/auth/signup/models/signup.dart';

class SignUpDataProvider {
  Client client = Client();
  SignUpDataProvider();

  Future signUpUser(SignUp signUp) async {
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('${ApiData.baseUrl}/users');

    var body = {
      "fullName": signUp.fullName,
      "phone": signUp.phone,
      "passwordHash": signUp.passwordHash
    };

    // var req = http.Request('POST', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);

    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    //////////////////
    var res =
    await client.post(url, headers: headersList, body: json.encode(body));
    final resBody = json.decode(res.body);
    ///////////////////////////
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);

      Login login =
      await Login(phone: signUp.phone, passwordHash: signUp.passwordHash);

      LoginDataProvider().loginUser(login);
    } else {
      print(res.reasonPhrase);
      throw Exception('Failed to SignUp.');
    }
  }

  Future signUpVerify(SignUp signUp) async {
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('${ApiData.baseUrl}/users/signup');

    var body = {
      "fullName": signUp.fullName,
      "phone": signUp.phone,
      "passwordHash": signUp.passwordHash
    };
    // var req = http.Request('POST', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);

    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    //////////////
    var res =
    await client.post(url, headers: headersList, body: json.encode(body));
    final resBody = json.decode(res.body);
    /////////////////////////
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }
}