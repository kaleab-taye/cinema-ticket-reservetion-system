import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:royal_cinema/features/mobile_customer/home/model/movie.dart';
import 'package:royal_cinema/features/mobile_customer/home/model/scheduledMovie.dart';
import 'package:sqflite/sqflite.dart';

class ScheduleLocalDbProvider{

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path,"cinema.db");

    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE Schedule(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          Schedule TEXT,
          )"""
          );
        });
  }

  Future<int> addUser(ScheduledMovie schedule) async{ //returns number of items inserted as an integer
    final db = await init(); //open database

    return db.insert("Schedule", schedule.toJson(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<int> updateUsers(String id, Map<String, dynamic> update) async{ // returns the number of rows updated

    final db = await init();

    int result = await db.update(
        "Schedule",
        update,
        where: "id = ?",
        whereArgs: [id]
    );
    return result;
  }

  Future deleteUsers() async {
    final db = await init();
    // return db.delete("delete from "+ TABLE_NAME);
    int deleted = await db.rawDelete("Delete from User");
    print(deleted);
    return deleted;
  }

  Future<ScheduledMovie> getUser() async{ //returns the memos as a list (array)

    final db = await init();
    final maps = await db.query("Schedule"); //query all the rows in a table as an array of maps

    return ScheduledMovie.fromJson(maps[0]);
  }
  Future<bool> isUserLoggedIn() async{ //returns the memos as a list (array)

    final db = await init();
    final maps = await db.query("User");
    return !maps.isEmpty;

  }

}