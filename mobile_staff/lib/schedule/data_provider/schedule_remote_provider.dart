import 'dart:convert';

import 'package:sec_2/core/api_data.dart';
import 'package:sec_2/schedule/data_provider/schedule_provider.dart';
import 'package:sec_2/schedule/model/schedule.dart';
import 'package:sec_2/schedule/model/schedule_response.dart';

import '../../core/user_data.dart';
import 'package:http/http.dart' as http;

class ScheduleRemoteProvider implements ScheduleProvider {
  final _baseUrl = '${apiData.baseUrl}/${UserData.token}'; //new
  static const authTok = apiData.userToken;
  // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoic3RhZmYiLCJpZCI6IjYyOThiOTZmZTk1OThmYWNmMGI2OTQwYyIsImlhdCI6MTY1NDIwMTg0NX0.BkxEosQ8y2jVSZkRDhfohOe9dB0K7wVOnv-VwHSu69k";

  late http.Client httpClient;

  final headersList = {
    "Accept": "*/*",
    "User-Agent": "Thunder Client (https://www.thunderclient.com)",
    "Authorization": authTok,
    'Content-Type': 'application/json'
  };

  @override
  Future<List<ScheduleResponse>> getAllSchedules() async {
    final response = await http.get(Uri.parse('${_baseUrl}/schedules'),
        headers: headersList);

    if (response.statusCode == 200) {
      final scheduleList = jsonDecode(response.body);

      List<ScheduleResponse> fetchedList = [];

      for (var key in scheduleList.keys) {
        List<Schedule> listSchedule = [];

        for (var schedule in scheduleList[key]) {
          listSchedule.add(Schedule.fromJson(schedule));
        }

        fetchedList.add(ScheduleResponse(date: key, schedules: listSchedule));
      }
      return fetchedList;
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Future<Schedule> addSchedule(Schedule schedule) async {
    var url = Uri.parse('$_baseUrl/schedules');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(schedule.toJson());

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final schedule = jsonDecode(resBody);
      return Schedule.fromJson(schedule);
    } else {
      throw Exception('Failed to create schedules');
    }
  }

  @override
  Future<Schedule> updateSchedule(Schedule schedule) async {
    print(schedule.id);
    // print(schedule.capacity);
    var url = Uri.parse('$_baseUrl/schedules/${schedule.id}');

    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(schedule.toJson());

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    print(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final schedule = jsonDecode(resBody);
      return Schedule.fromJson(schedule);
    } else {
      throw Exception('Failed to create schedules');
    }
  }

  @override
  Future<bool> deleteSchedule(String id) async {
    print(id);
    // print(schedule.capacity);
    var url = Uri.parse('$_baseUrl/schedules/$id');

    var req = http.Request('DELETE', url);
    req.headers.addAll(headersList);
    // req.body = jsonEncode(schedule.toJson());

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    print(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final schedule = jsonDecode(resBody);
      return resBody.toLowerCase() == 'true' ? true : false;
    } else {
      throw Exception('Failed to create schedules');
    }
  }
}
