import 'dart:convert';

import 'package:flutter_network/core/user_data.dart';

import 'package:meta/meta.dart';
import 'package:flutter_network/movie/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieDataProvider {
  final _baseUrl = 'http://127.0.0.1:5000/${UserData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';
  final http.Client httpClient;

  MovieDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Movie> createMovie(Movie movie) async {
    final response = await httpClient.post(
      Uri.http('$_baseUrl', '/movies'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': movie.title,
        'imageUrl': movie.imageUrl,
        'description': movie.description,
        'casts': movie.casts,
      }),
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create movie.');
    }
  }

  Future<List<Movie>> getMovies() async {
    final response = await httpClient.get('$_baseUrl/movies');
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      //
      // print(movies.map((movie) => Movie.fromJson(movie)).toList());
      // print(movies);
      //
      // return movies.map((movie) => Movie.fromJson(movie)).toList();
      print(-2);
      List<Movie> c = await movies.map((movie) {
        print(-4);
        print(movie);
        Movie c2 = Movie.fromJson(movie);
        print(-3);
        return c2;
      }).toList();
      print(-1);
      return c;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> deleteMovie(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/movies/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete movie.');
    }
  }

  Future<void> updateMovie(Movie movie) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/movies/${movie.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': movie.id,
        'title': movie.title,
        'code': movie.imageUrl,
        'description': movie.description,
        'casts': movie.casts,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update movie.');
    }
  }
}
