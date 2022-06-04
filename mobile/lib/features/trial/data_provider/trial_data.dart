import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/auth/signup/models/signup.dart';

import '../../../../core/token_data.dart';

class TrialDataProvider {

  TrialDataProvider();

  Future trialUser(String id) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)'
    };
    var url = Uri.parse(
        'http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/users/$id');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      final trialList = jsonDecode(resBody) as List;
      // Trial user = await trialList.map((movie) {
      //   Trial movies = Trial.fromJson(movie);
      //   return movies;
      // }).toList();

      return trialList;
    }
    else {
      print(res.reasonPhrase);
    }
  }
}
