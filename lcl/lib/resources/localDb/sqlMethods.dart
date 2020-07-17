import 'package:lcl/resources/localDb/interface/settingsInterface.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteMethods implements SettingsInterface {
  Database _db;

  String databaseName = "SettingsDB";

  String tableName = "SettingsData";

  String sId = 'sId';
  int sAge = 18;
  int sDistance = 1;
  String sGender = 'sGender';
  String sInterestedIn = '';
  String sMode = 'sMode';
  String sLocation = '';


  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print("db was null, now awaiting it");
    _db = await init();
    return _db;
  }

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $tableName ($sId INTEGER PRIMARY KEY, $sAge INTEGER, $sDistance INTEGER, $sGender TEXT, $sInterestedIn TEXT, $sMode TEXT, $sLocation TEXT)";

    await db.execute(createTableQuery);
    print("table created");
  }

  @override
  addLogs(Log log) async {
    var dbClient = await db;
    await dbClient.insert(tableName, log.toMap(log));
  }

  @override
  deleteLogs(int logId) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: '$id = ?', whereArgs: [logId]);
  }

  updateLogs(Log log) async {
    var dbClient = await db;

    await dbClient.update(
      tableName,
      log.toMap(log),
      where: '$id = ?',
      whereArgs: [log.logId],
    );
  }

  @override
  Future<List<Log>> getLogs() async {
    try {
      var dbClient = await db;

      // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $tableName");
      List<Map> maps = await dbClient.query(
        tableName,
        columns: [
          id,
          callerName,
          callerPic,
          receiverName,
          receiverPic,
          callStatus,
          timestamp,
        ],
      );

      List<Log> logList = [];

      if (maps.isNotEmpty) {
        for (Map map in maps) {
          logList.add(Log.fromMap(map));
        }
      }

      return logList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}