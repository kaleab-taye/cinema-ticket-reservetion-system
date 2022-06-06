
import 'dart:convert';

import 'package:royal_cinema/core/customer_core/api_data.dart';
import 'package:royal_cinema/core/customer_core/local_data_provider.dart';
import 'package:royal_cinema/core/customer_core/token_data.dart';
import 'package:http/http.dart' show Client;
import 'package:royal_cinema/features/mobile_customer/user/model/user.dart';

import '../model/schedule_response.dart';
import '../model/scheduledMovie.dart';
import 'schedule_provider.dart';

class ScheduledRemoteProvider implements ScheduledProvider {
  Client client = Client();

  LocalDbProvider localDbProvider = LocalDbProvider();


  @override
  addScheduled(ScheduledMovie scheduled) async {

    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/schedules');

    var body = {
      "movieId": scheduled.movieId,
      "movie": scheduled.movie,
      "startTime": scheduled.startTime,
      "endTime": scheduled.endTime,
      "capacity": scheduled.capacity,
      "seatsLeft": scheduled.seatsLeft,
      "price": scheduled.price
    };
    // var req = http.Request('POST', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);
    //
    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    //////////////////
    var res =
    await client.post(url, headers: headersList, body: json.encode(body));
    final resBody = json.decode(res.body);
    ///////////////////////////

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      throw Exception('Failed to create schedules.');
    }
  }

  @override
  editScheduled(String id, ScheduledMovie scheduled) async {
    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/schedules/${scheduled.id}');

    var body = {
      "movieId": scheduled.movieId,
      "movie": scheduled.movie,
      "startTime": scheduled.startTime,
      "endTime": scheduled.endTime,
      "capacity": scheduled.capacity,
      "seatsLeft": scheduled.seatsLeft,
      "price": scheduled.price
    };
    // var req = http.Request('PATCH', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);
    //
    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    //////////////////
    var res =
    await client.patch(url, headers: headersList, body: json.encode(body));
    final resBody = json.decode(res.body);
    ///////////////////////////

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      throw Exception('Failed to update schedules.');
    }
  }

  @override
  Future<ScheduledMovie?> getScheduled(String id) async {
    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/schedules');

    var body = {

    };
    // var req = http.Request('GET', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);
    //
    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    //////////////////
    var res =
    await client.get(url, headers: headersList);
    final resBody = json.decode(res.body);
    ///////////////////////////
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
  Future<List<ScheduleResponse>> getAllScheduleds() async {

    User userOut = await localDbProvider.getUser();

    print(userOut.loginToken);

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    //
    // final response = await http.get(Uri.parse('${ApiData.baseUrl}/schedules'),
    //     headers: headersList);

    //////////////////
    var response =
    await client.get(Uri.parse('${ApiData.baseUrl}/schedules'), headers: headersList);
    final resBody = json.decode(response.body);
    ///////////////////////////
    if (response.statusCode == 200) {

      final scheduleList = jsonDecode(response.body);

      List<ScheduleResponse> fetchedList = [];

      for (var key in scheduleList.keys) {

        List<ScheduledMovie> listSchedule = [];

        for (var schedule in scheduleList[key]) {
          listSchedule.add(ScheduledMovie.fromJson(schedule));
        }

        fetchedList.add(ScheduleResponse(date: key, schedules: listSchedule));
      }

      // print(fetchedList[0].schedules[0].movie);

      return fetchedList;
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  // @override
  // Future<List<ScheduleResponse>> getAllScheduleds() async {
  //
  //   var headersList = {
  //     'Accept': '*/*',
  //     'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
  //     'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoidXNlciIsImlkIjoiNjI5OGExZTcyYjEyYWFhYTI5ODYzODJjIiwiaWF0IjoxNjU0MTcwMTUzfQ.KpOgJoKqfp55TN9y3vfGdibl_taN5tgGojEoCVSCrMc',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('${ApiData.baseUrl}/schedules');
  //
  //   var body = {
  //   };
  //   var req = http.Request('GET', url);
  //   req.headers.addAll(headersList);
  //   req.body = json.encode(body);
  //
  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();
  //
  //   // final response = await http.get(Uri.parse('$_baseUrl/schedules'));
  //
  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //
  //     final scheduleList = jsonDecode(resBody);
  //
  //     List<ScheduleResponse> fetchedList = [];
  //
  //     for (var key in scheduleList.keys) {
  //
  //       List<ScheduledMovie> listSchedule = [];
  //
  //       for (var schedule in scheduleList[key]) {
  //         listSchedule.add(ScheduledMovie.fromJson(schedule));
  //       }
  //
  //       fetchedList.add(ScheduleResponse(date: key, schedules: listSchedule));
  //     }
  //
  //
  //     return fetchedList;
  //
  //     // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDD");
  //     // print(resBody);
  //     //
  //     // final schedulesList = jsonDecode(resBody);
  //     //
  //     // List<ScheduledMovie> fetchedList = [];
  //     //
  //     // print(schedulesList);
  //     // List<ScheduledMovie> c = await schedulesList.map((scheduled) {
  //     //   ScheduledMovie c2 = ScheduledMovie.fromJson(scheduled);
  //     //   return c2;
  //     // }).toList();
  //     // return c;
  //   } else {
  //     print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBbb");
  //     throw Exception();
  //   }
  // }
}
