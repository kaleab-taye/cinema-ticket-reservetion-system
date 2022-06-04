import 'dart:convert';

import 'package:sec_2/core/api_data.dart';

import '../../core/user_data.dart';

import 'package:sec_2/movie/index.dart';
import 'package:http/http.dart' as http;

class MovieRemoteProvider implements MovieProvider {
  final _baseUrl = '${apiData.baseUrl}/${UserData.token}'; //new

  late http.Client httpClient;

  @override
  Future<List<Movie>> getAllMovies() async {
    final response = await http.get(Uri.parse('${_baseUrl}/movies'));
    // final response = await httpClient.get(_baseUrl);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
