
import 'dart:convert';

import 'package:royal_cinema/core/local_data_provider.dart';
import 'package:royal_cinema/core/token_data.dart';

import '../model/user.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'user_provider.dart';
import 'package:http/http.dart' as http;

class UserRemoteProvider implements UserProvider {

  LocalDbProvider localDbProvider = LocalDbProvider();

  @override
  updateBalance(int price) async {

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaa");

    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/users/${userOut.id}');

    var body = {
      "balance": userOut.balance - price
    };

    localDbProvider.updateUsers(userOut.id!, body);

    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  @override
  Future<User?> getUser(String id) async {
    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/users/$id');

    var body = {

    };
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {

      print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbb");
      print(resBody);

      final List users = json.decode(resBody);

      for (int i = 0; i < users.length; i++) {
        if (users[i].id == id) {
          return users[i];
        }
    }
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };

    final response = await http.get(Uri.parse('${ApiData.baseUrl}/users'));

    if (response.statusCode == 200) {
      final courses = jsonDecode(response.body) as List;
      //
      // print(courses.map((course) => Course.fromJson(course)).toList());
      // print(courses);
      //
      // return courses.map((course) => Course.fromJson(course)).toList();
      List<User> c = await courses.map((user) {
        User c2 = User.fromJson(user);
        return c2;
      }).toList();
      return c;
    // var headersList = {
    //   'Accept': '*/*',
    //   'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    //   'Content-Type': 'application/json'
    // };
    // var url = Uri.parse('${ApiData.baseUrl}/users');
    //
    // var body = {
    //
    // };
    // var req = http.Request('GET', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);
    //
    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();
    //
    // print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbb");
    // print(json.decode(resBody));
    //
    // if (res.statusCode >= 200 && res.statusCode < 300) {
    //   final List<User> users = json.decode(resBody);
    //
    //   return users;

      // return users.map((json) => User.fromJson(json)).where((user) {
      //   final userTitleLower = user.title.toLowerCase();
      //   final searchLower = query.toLowerCase();
      //
      //   return userTitleLower.contains(searchLower);
      // }).toList();
    } else {
      throw Exception();
    }
  }
}
