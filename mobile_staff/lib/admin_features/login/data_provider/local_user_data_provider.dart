// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sec_2/user/models/loggedIn_user.dart';
// import 'package:sec_2/user/models/user.dart';
// import 'package:sqflite/sqflite.dart';

// class LocalDbProvider {
//   Future<Database> init() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     final path = join(directory.path, "cinema.db");

//     return await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute("""
//           CREATE TABLE User(
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           fullName TEXT,
//           phone TEXT,
//           passwordHash TEXT,
//           balance DOUBLE,
//           loginToken TEXT
//           )""");
//     });
//   }

//   Future<int> addUser(User user) async {
//     //returns number of items inserted as an integer
//     final db = await init(); //open database

//     return db.insert(
//       "User", user.toJson(), //toMap() function from MemoModel
//       conflictAlgorithm:
//           ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
//     );
//   }

//   Future deleteUsers() async {
//     final db = await init();
//     // return db.delete("delete from "+ TABLE_NAME);
//     int deleted = await db.rawDelete("Delete from User");
//     print(deleted);
//     return deleted;
//   }

//   Future<LoggedInUser> getUser() async {
//     //returns the memos as a list (array)

//     final db = await init();
//     final maps = await db
//         .query("User"); //query all the rows in a table as an array of maps

//     return LoggedInUser(
//         user: User(
//           fullName: maps[0]['fullName'].toString(),
//           phone: maps[0]['phone'].toString(),
//           passwordHash: maps[0]['passwordHash'].toString(),
//           balance: int.parse(maps[0]['balance'].toString()),
//         ),
//         loginToken: maps[0]['loginToken'].toString());

//     // User(
//     //     fullName: maps[0]['fullName'].toString(),
//     //     phone: maps[0]['phone'].toString(),
//     //     passwordHash: maps[0]['passwordHash'].toString(),
//     //     balance: int.parse(maps[0]['balance'].toString()),
//     //     loginToken: maps[0]['loginToken'].toString()
//     // );
//   }

//   Future<bool> isUserLoggedIn() async {
//     //returns the memos as a list (array)

//     final db = await init();
//     final maps = await db.query("User");
//     return !maps.isEmpty;
//   }

//   Future<bool> isEmpty() async {
//     final db = await init();
//     final maps = await db.query("User");
//     if (maps.isEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
