import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royal_cinema/features/mobile_customer/auth/login/login.dart';
import 'package:royal_cinema/features/mobile_customer/auth/login/models/login.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

Future<Response> mockAPI(req) async {
  Map<String, dynamic> reqBody = json.decode(req.body);
  bool valid = reqBody["phone"] != null && reqBody["passwordHash"] != null;
  if (valid) {
    Map<String, dynamic> userLoginData = {
      "user": {
        "id": "gfgfgftftrtftytfgvb",
        "fullName": "Some One",
        "phone": "0987654321",
        "passwordHash": "ghytytgvghgfvggvtybjkj",
        "balance": 200
      },
      "loginToken": "qwertyuiopasdfghjkl.qwertyuiopcvbnm.qwertyuiosdfghjkl"
    };
    return Response(json.encode(userLoginData), valid ? 200 : 400);
  } else {
    return Response(json.encode(valid), valid ? 200 : 400);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  test('loginUser shall return true for valid LogIn object: ', () async {
    LoginDataProvider loginDataProvider = LoginDataProvider();
    loginDataProvider.client = MockClient(mockAPI);
    LoginRepository loginRepository = LoginRepository(loginDataProvider);

    final loggedIn = await loginRepository.loginUser(
      Login(
        phone: "0987654321",
        passwordHash: "qwertyuasdfgwertyuio",
      ),
    );
    expect(loggedIn, true);
  });
}
