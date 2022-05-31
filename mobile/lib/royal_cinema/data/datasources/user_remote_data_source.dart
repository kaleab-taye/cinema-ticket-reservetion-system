
import 'dart:convert';

import 'package:royal_cinema/royal_cinema/data/models/user_model.dart';

import '../../../core/error/exception.dart';
import 'package:http/http.dart' as http;


abstract class UserRemoteDataSource {
  /// Calls the http://getuserapi.com endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<UserModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}