import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'repository.dart';
import '../models/item_model.dart';

class ShareDbProvider implements Source, Cache {
  ShareDbProvider._privateConstructor();

  static final ShareDbProvider instance = ShareDbProvider._privateConstructor();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "items16.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database newDb, int version) async {
    print('New Table');
    await newDb.execute("""
          CREATE TABLE Items
          (
            companyName TEXT,
            noOfTransactions INTEGER,
            maxPrice DOUBLE,
            minPrice DOUBLE,
            closingPrice DOUBLE,
            tradedShares INTEGER,
            amount DOUBLE,
            previousClosing DOUBLE,
            difference DOUBLE 
          )
          """);
  }

  Future<int> addShare(ItemModel item) async {
    Database db = await instance.database;
    return await db.insert(
      "Items",
      item.toMapForDb(),
    );
  }

  Future<List<ItemModel>> fetchShare() async {
    Database db = await instance.database;
    List<ItemModel> list = new List<ItemModel>();
    final maps = await db.query("Items");
    maps.forEach((map) => list.add(ItemModel.fromDb(map)));
    return list;
  }

  Future<int> deleteShare() async {
    Database db = await instance.database;
    return await db.delete("Items");
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM Items'));
  }
}
