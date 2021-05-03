import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';

class UserInfoDb {
  Database db;

  UserInfoDb() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'userInfo2.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      print('HERE AT DB');
      newDb.execute("""
              CREATE TABLE UserInfo
              (
                userId INTEGER PRIMARY KEY,
                firstName TEXT,
                lastName TEXT,
                password TEXT,
                stocks BLOB,
                watchList BLOB
              )
        """);
    });
  }

  Future<bool> checkValidity(int userId, String password) async {
    final maps = await db.query(
      'UserInfo',
      columns: null,
      where: "userId = ?",
      whereArgs: [userId],
    );
    if (maps.length > 0) {
      if (maps.first['userId'] == userId &&
          maps.first['password'] == password) {
        return true;
      }
    }
    return false;
  }

  Future<int> addUser(UserModel user) {
    print('here user_info_db');
    return db.insert(
      "UserInfo",
      user.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
