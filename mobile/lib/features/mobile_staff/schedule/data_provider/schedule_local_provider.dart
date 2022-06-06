import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:royal_cinema/features/mobile_staff/movie/index.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/model/schedule.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sec_2/user/models/staff.dart';
// import 'package:sqflite/sqflite.dart';

import '../../user/models/staff.dart';

class IndexDataProvider {
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "test2.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE Schedule(
          id TEXT PRIMARY KEY,
          movieId TEXT,
          movie TEXT,
          startTime INTEGER,
          endTime INTEGER,
          capacity INTEGER,
          seatsLeft INTEGER,
          price INTEGER
          )""");
    });
  }

  Future<int> addSchedule(Schedule schedule) async {
    //returns number of items inserted as an integer
    final db = await init(); //open database

    Map<String, dynamic> data = {
      "id": schedule.id!,
      "movieId": schedule.movieId,
      "movie": schedule.movie!.title,
      "startTime": schedule.startTime,
      "endTime": schedule.endTime,
      "capacity": schedule.capacity,
      "seatsLeft": schedule.seatsLeft,
      "price": schedule.price,
    };

    return db.insert(
      "Staff", data, //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<int> removeSchedules() async {
    final db = await init();
    // return db.delete("delete from "+ TABLE_NAME);
    int deleted = await db.rawDelete("Delete from Schedule");
    print(deleted);
    return deleted;
  }

  Future<Schedule> getSchedules() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("Schedule"); //query all the rows in a table as an array of maps

    return Schedule(
        id: maps[0]['id'].toString(),
        movieId: maps[0]['movieId'].toString(),
        movie: Movie(title: maps[0]['movie'].toString()) ,
        startTime: int.parse(maps[0]['startTime'].toString()),
        endTime: int.parse(maps[0]['endTime'].toString()),
        capacity: int.parse(maps[0]['capacity'].toString()),
        seatsLeft: int.parse(maps[0]['seatsLeft'].toString()),
        price: int.parse(maps[0]['price'].toString()),
        );
  }

  Future<bool> isStaffLoggedIn() async {
    //returns the memos as a list (array)
    final db = await init();
    final maps = await db.query("Staff");
    return !maps.isEmpty;
  }

  // Future<bool> isEmpty() async {
  //   final db = await init();
  //   final maps = await db.query("User");
  //   if (maps.isEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
