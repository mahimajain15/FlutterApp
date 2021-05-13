import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseRepository {
  DatabaseRepository.privateConstructor();

  static final DatabaseRepository instance =
  DatabaseRepository.privateConstructor();

  final _databaseName = 'Data.db';
  final _databaseVersion = 1;

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else
      _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory dataDirectroy = await getApplicationDocumentsDirectory();
    String path = join(dataDirectroy.path, _databaseName);
    return await openDatabase(
        path, version: _databaseVersion, onCreate: await onCreateDB);
  }

  Future onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE person(
      colPId INTEGER PRIMARY KEY AUTOINCREMENT,
      colName TEXT NOT NULL,
      colCId TEXT NOT NULL,      
      colUId TEXT NOT NULL,
      colPwd TEXT NOT NULL,
      FK_Person_Address STRING NOT NULL,
      FOREIGN KEY (FK_Person_Address) REFERENCES Address (colAId)
    )
    ''');
    await db.execute('''
    CREATE TABLE address(
      colAId INTEGER PRIMARY KEY AUTOINCREMENT,
      colSt1 TEXT NOT NULL,
      colSt2 TEXT NOT NULL,
      colCity TEXT NOT NULL,
      colState TEXT NOT NULL,
      colZip TEXT NOT NULL,
      colCnt TEXT NOT NULL
    )
    ''');
  }
}

