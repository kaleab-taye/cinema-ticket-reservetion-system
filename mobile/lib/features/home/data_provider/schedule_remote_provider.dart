
import 'dart:convert';

import 'package:royal_cinema/core/token_data.dart';
import 'package:http/http.dart' as http;

import '../model/scheduledMovie.dart';
import 'schedule_provider.dart';

class ScheduledRemoteProvider implements ScheduledProvider {

  final _baseUrl = 'http://127.0.0.1:5000/${TokenData.token}'; //new
  // final _baseUrl = 'http://192.168.56.1:3000';

  @override
  addScheduled(ScheduledMovie scheduled) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/schedules');

    var body = {
      "movieId": scheduled.movieId,
      "movie": scheduled.movie,
      "startingTime": scheduled.startingTime,
      "endTime": scheduled.endTime,
      "capacity": scheduled.capacity,
      "seatsLeft": scheduled.seatsLeft,
      "price": scheduled.price
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
      throw Exception('Failed to create schedules.');
    }
  }

  @override
  editScheduled(String id, ScheduledMovie scheduled) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/schedules/${scheduled.id}');

    var body = {
      "movieId": scheduled.movieId,
      "movie": scheduled.movie,
      "startingTime": scheduled.startingTime,
      "endTime": scheduled.endTime,
      "capacity": scheduled.capacity,
      "seatsLeft": scheduled.seatsLeft,
      "price": scheduled.price
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
      throw Exception('Failed to update schedules.');
    }
  }

  @override
  Future<ScheduledMovie?> getScheduled(String id) async {
    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer token",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/schedules');

    var body = {

    };
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final List scheduleds = json.decode(resBody);

      for (int i = 0; i < scheduleds.length; i++) {
        if (scheduleds[i].id == id) {
          return scheduleds[i];
        }
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ScheduledMovie>> getAllScheduleds() async {
    final response = await http.get(Uri.parse('$_baseUrl/schedules'));

    if (response.statusCode == 200) {
      final courses = jsonDecode(response.body) as List;
      //
      // print(courses.map((course) => Course.fromJson(course)).toList());
      // print(courses);
      //
      // return courses.map((course) => Course.fromJson(course)).toList();
      List<ScheduledMovie> c = await courses.map((scheduled) {
        ScheduledMovie c2 = ScheduledMovie.fromJson(scheduled);
        return c2;
      }).toList();
      return c;
      // var headersList = {
      //   'Accept': '*/*',
      //   'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      //   'Content-Type': 'application/json'
      // };
      // var url = Uri.parse('http://127.0.0.1:5000/token:bhjbtyBHgtyvytyv/scheduleds');
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
      //   final List<Scheduled> scheduleds = json.decode(resBody);
      //
      //   return scheduleds;

      // return scheduleds.map((json) => Scheduled.fromJson(json)).where((scheduled) {
      //   final scheduledTitleLower = scheduled.title.toLowerCase();
      //   final searchLower = query.toLowerCase();
      //
      //   return scheduledTitleLower.contains(searchLower);
      // }).toList();
    } else {
      throw Exception();
    }
  }
}
