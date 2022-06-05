
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
  Map<String, dynamic> reqBody = json.decode(req.body);
  bool valid = req.toString().endsWith("/schedules");
  return Response(json.encode(valid), valid ? 200 : 400);
}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
setUpAll(()async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  Database db = await openDatabase(
      "cinema.db",
      version: 1,
      onCreate: (Database db,int version) async{
        await db.execute("""
          CREATE TABLE User(
          id TEXT PRIMARY KEY,
          fullName TEXT,
          phone TEXT,
          passwordHash TEXT,
          balance INTEGER,
          loginToken TEXT
          )"""
        );
      });
 await db.insert("User", {"id":"myId","fullName":"fn","phone":"098","passwordHash":"pass","balance":"1000","loginToken":"token"},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
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
