import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:royal_cinema/core/utils/either.dart';
import 'package:royal_cinema/features/home/data_provider/schedule_remote_provider.dart';
import 'package:royal_cinema/features/home/model/schedule_response.dart';
import 'package:royal_cinema/features/home/repository/schedule_repository.dart';
// import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

Future<Response> mockAPI(req) async {
  bool valid = req.toString().endsWith("/schedules");
  if (valid) {
    Map<String, dynamic> schedules = {
      "Today": [
        {
          "id": "629b987bdd7cc6593b173fe6",
          "movieId": "629b987add7cc6593b173fde",
          "startTime": 1654437600000,
          "movie": {
            "id": "629b987add7cc6593b173fde",
            "title": "War Horse",
            "description":
                "Albert and his horse Joey are inseparable. However, when Joey is sold off to the British cavalry, Albert follows him in the hope of reuniting with his best friend.",
            "imageUrl": "images/war-horse.jpg",
            "casts": [
              "Sam Worthington",
              "Stephen Lang",
              "Sigourney Weaver",
              "Michelle Rodriguez"
            ],
            "genera": ["war", "drama"]
          },
          "endTime": 1654444800000,
          "capacity": 200,
          "seatsLeft": 200,
          "price": 50
        },
      ],
    };
    return Response(json.encode(schedules), valid ? 200 : 400);
  }
  return Response(json.encode(valid), valid ? 200 : 400);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    // Database db = await openDatabase(
    //     "cinema.db",
    //     version: 1,
    //     onCreate: (Database db,int version) async{
    //       await db.execute("""
    //         CREATE TABLE User(
    //         id TEXT PRIMARY KEY,
    //         fullName TEXT,
    //         phone TEXT,
    //         passwordHash TEXT,
    //         balance INTEGER,
    //         loginToken TEXT
    //         )"""
    //       );
    //     });
//  await db.insert("User", {"id":"myId","fullName":"fn","phone":"098","passwordHash":"pass","balance":"1000","loginToken":"token"},
//       conflictAlgorithm: ConflictAlgorithm.ignore,
//     );
  });
  test('getAllScheduleds shall return a value with .hasError false: ',
      () async {
    ScheduledRemoteProvider scheduledRemoteProvider = ScheduledRemoteProvider();
    scheduledRemoteProvider.client = MockClient(mockAPI);
    ScheduledRepository scheduledRepository =
        ScheduledRepository(scheduledRemoteProvider);

    Either<List<ScheduleResponse>> allSchedules =
        await scheduledRepository.getAllScheduleds();
    expect(allSchedules.hasError, false);
  });
}
