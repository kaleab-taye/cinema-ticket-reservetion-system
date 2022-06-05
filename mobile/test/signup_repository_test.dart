import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royal_cinema/features/auth/signup/models/signup.dart';
import 'package:test/test.dart';
import 'package:royal_cinema/features/auth/signup/repository/signup_repository.dart';
import 'package:royal_cinema/features/auth/signup/data_provider/signup_data.dart';

Future<Response> mockAPI(req) async {
  Map<String, dynamic> reqBody = json.decode(req.body);
  bool valid = reqBody["fullName"] != null &&
      reqBody["phone"] != null &&
      reqBody["passwordHash"] != null;
  return Response(json.encode(valid), valid ? 200 : 400);
}

void main() {
  test('signUpUser shall return true for valid SignUp object: ', () async {
    SignUpDataProvider signUpDataProvider = SignUpDataProvider();
    signUpDataProvider.client = MockClient(mockAPI);
    SignUpRepository signUpRepository = SignUpRepository(signUpDataProvider);

    final signedUp = await signUpRepository.signUpUser(
      SignUp(
        fullName: "Some One",
        phone: "0987654321",
        passwordHash: "qwertyuasdfgwertyuio",
      ),
    );
    expect(signedUp, true);
  });

  test('signUpVerify shall return true for valid SignUp object: ', () async {
    SignUpDataProvider signUpDataProvider = SignUpDataProvider();
    signUpDataProvider.client = MockClient(mockAPI);
    SignUpRepository signUpRepository = SignUpRepository(signUpDataProvider);

    final signUpVerified = await signUpRepository.signUpVerify(
      SignUp(
        fullName: "Some One",
        phone: "0987654321",
        passwordHash: "qwertyuasdfgwertyuio",
      ),
    );
    expect(signUpVerified, true);
  });
}
