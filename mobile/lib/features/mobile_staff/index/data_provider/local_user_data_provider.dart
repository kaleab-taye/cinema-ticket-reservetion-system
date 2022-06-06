import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
          CREATE TABLE Staff(
          id TEXT PRIMARY KEY,
          fullName TEXT,
          phone TEXT,
          passwordHash TEXT,
          loginToken TEXT
          )""");
    });
  }

  Future<int> loginStaff(Staff staff) async {
    //returns number of items inserted as an integer
    final db = await init(); //open database

    return db.insert(
      "Staff", staff.toJson(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<int> logoutStaff() async {
    final db = await init();
    // return db.delete("delete from "+ TABLE_NAME);
    int deleted = await db.rawDelete("Delete from Staff");
    print(deleted);
    return deleted;
  }

  Future<Staff> getLoggedInStaff() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("Staff"); //query all the rows in a table as an array of maps

    return Staff(
        id: maps[0]['id'].toString(),
        fullName: maps[0]['fullName'].toString(),
        phone: maps[0]['phone'].toString(),
        passwordHash: maps[0]['passwordHash'].toString(),
        loginToken: maps[0]['loginToken'].toString());
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
