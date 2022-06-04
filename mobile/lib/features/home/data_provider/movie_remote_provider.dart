
import 'dart:convert';

import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/core/token_data.dart';

import '../model/movie.dart';
import 'movie_provider.dart';
import 'package:http/http.dart' as http;

class MovieRemoteProvider implements MovieProvider {

  @override
  addMovie(Movie movie) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/movies');

    var body = {
      "title": movie.title,
      "description": movie.description,
      "imageUrl": movie.imageUrl,
      "casts": movie.casts,
      "genera": movie.genera
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      throw Exception('Failed to create movie.');
    }
  }

  @override
  editMovie(String id, Movie movie) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/movies/${movie.id}');

    var body = {
      "title": movie.title,
      "description": movie.description,
      "imageUrl": movie.imageUrl,
      "casts": movie.casts,
      "genera": movie.genera
    };
    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      throw Exception('Failed to update movie.');
    }
  }

  @override
  Future<Movie?> getMovie(String id) async {
    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer token",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/movies');

    var body = {

    };
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final List movies = json.decode(resBody);

      for (int i = 0; i < movies.length; i++) {
        if (movies[i].id == id) {
          return movies[i];
        }
    }
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Movie>> getAllMovies() async {
    final response = await http.get(Uri.parse('${ApiData.baseUrl}/movies'));

    if (response.statusCode == 200) {
      final moviesList = jsonDecode(response.body) as List;
      //
      // print(courses.map((course) => Course.fromJson(course)).toList());
      // print(courses);
      //
      // return courses.map((course) => Course.fromJson(course)).toList();
      List<Movie> allMovies = await moviesList.map((movie) {
        Movie movies = Movie.fromJson(movie);
        return movies;
      }).toList();

      return allMovies;
    // var headersList = {
    //   'Accept': '*/*',
    //   'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    //   'Content-Type': 'application/json'
    // };
    // var url = Uri.parse('${ApiData.baseUrl}/movies');
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
    //   final List<Movie> movies = json.decode(resBody);
    //
    //   return movies;

      // return movies.map((json) => Movie.fromJson(json)).where((movie) {
      //   final movieTitleLower = movie.title.toLowerCase();
      //   final searchLower = query.toLowerCase();
      //
      //   return movieTitleLower.contains(searchLower);
      // }).toList();
    } else {
      throw Exception();
    }
  }
}
