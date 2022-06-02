
import 'dart:convert';

import 'package:royal_cinema/core/token_data.dart';

import '../model/movie.dart';
import 'movie_provider.dart';
import 'package:http/http.dart' as http;

class MovieRemoteProvider implements MovieProvider {

  final _baseUrl = 'http://127.0.0.1:5000/${TokenData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';

  @override
  addMovie(Movie movie) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/movies');

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
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/movies/${movie.id}');

    var body = {
      "title": movie.title,
      "description": movie.description,
      "imageUrl": movie.imageUrl,
      "casts": movie.casts,
      "genera": movie.genera,
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
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      "Authorization": "Bearer token",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/movies');

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
    final response = await http.get(Uri.parse('$_baseUrl/movies'));

    if (response.statusCode == 200) {
      final courses = jsonDecode(response.body) as List;
      //
      // print(courses.map((course) => Course.fromJson(course)).toList());
      // print(courses);
      //
      // return courses.map((course) => Course.fromJson(course)).toList();
      List<Movie> c = await courses.map((movie) {
        Movie c2 = Movie.fromJson(movie);
        return c2;
      }).toList();
      return c;
    // var headersList = {
    //   'Accept': '*/*',
    //   'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    //   'Content-Type': 'application/json'
    // };
    // var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/movies');
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
