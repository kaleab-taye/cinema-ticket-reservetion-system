import 'dart:convert';
import 'package:sec_2/core/api_data.dart';
import 'package:sec_2/index/data_provider/local_user_data_provider.dart';
import 'package:sec_2/index/repository/index_repository.dart';
import 'package:sec_2/login/models/login_response.dart';
import 'package:sec_2/user/models/staff.dart';

import '../../core/user_data.dart';
import 'package:sec_2/movie/index.dart';
import 'package:http/http.dart' as http;

class LoginDataProvider {
  final _baseUrl = apiData.baseUrl; //new

  late http.Client httpClient;

  final IndexRepository indexRepo = IndexRepository(IndexDataProvider());

  @override
  Future<LoginResponse> getLoggedIn(loginData) async {
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};

    final requestBody = {
      "phone": "${loginData.phone}",
      "passwordHash": "${loginData.passwordHash}"
    };

    var url = Uri.parse('$_baseUrl/${UserData.token}/staffs/login');

    var request = http.Request('POST', url);
    request.headers.addAll(headersList);
    request.body = json.encode(requestBody);

    var resp = await request.send();

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final respBody = await resp.stream.bytesToString();
      final finalResponse = await jsonDecode(respBody);

      print("0000000000000000000000000000000000000000000000000000");
      print(finalResponse);
      print(finalResponse['loginToken']);
      indexRepo.loginStaff(Staff(
          fullName: finalResponse['staff']['fullName'],
          phone: finalResponse['staff']['phone'],
          passwordHash: finalResponse['staff']['passwordHash'],
          loginToken: finalResponse['loginToken'],
          ));

      return LoginResponse.fromJson(finalResponse);
    } else {
      throw Exception('Failed to Login.');
    }
  }
}
