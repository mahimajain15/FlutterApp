import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:nutralike_app/models/person.dart';
import 'package:nutralike_app/models/address.dart';

const oneSecond = Duration(seconds: 1);

class DatabaseRepository {
  // DatabaseRepository.privateConstructor();

  // static final DatabaseRepository instance =
  // DatabaseRepository.privateConstructor();

  static const _databaseName = 'db';
  static const _databaseVersion = 1;

  DatabaseRepository._(); //singleton class
  static final DatabaseRepository instance = DatabaseRepository._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectroy = await getApplicationDocumentsDirectory();
    Database db = await Future.delayed(oneSecond);
    String dbpath = join(dataDirectroy.path, _databaseName);
    return await openDatabase(
        dbpath, version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE person(
      colPId INTEGER PRIMARY KEY AUTOINCREMENT,
      colName TEXT NOT NULL,
      colCId TEXT NOT NULL,      
      colUId TEXT NOT NULL,
      colPwd TEXT NOT NULL,
      FK_Person_Address INTEGER,
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



  // Insert in person table
  Future<int> insertPerson(Person person) async {
    Database db = await database;
    return await db.insert('person', person.toMap());
    // print('person details inserted');
  }

  // Update in person table
  Future<int> updatePerson(Person person) async {
    final db = await database;
    return await db.update('person', person.toMap(),
        where: 'colPId=?', whereArgs: [person.pid]);
  }

  // Delete in person table
  Future<int> deletePerson(Person person) async {
    final db = await database;
    return await db.delete('person',
        where: 'colPId=?', whereArgs: [person.pid]);
  }

  // Display in person table
  Future<List<Person>> fetchPersons() async {
    final db = await database;
    List<Map> persons = await db.query('person');
    return persons.length == 0
    ?[]
    :persons.map((e) => Person.fromMap(e)).toList();
  }

  Future<List<Person>> getAllPerson() async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.query('person');
    List<Person> persons =
    allRows.map((person) => Person.fromMap(person)).toList();
    return persons;
  }

  Future<List<Person>> getAllPersonByAddress(Address address) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.rawQuery('''
    SELECT * FROM person
    WHERE person.FK_person_address = ${address.aid}
    ''');
    List<Person> persons =
    allRows.map((person) => Person.fromMap(person)).toList();
    return persons;
  }

  // Insert in address table
  Future<int> insertAddress(Address address) async {
    final db = await database;
    return await db.insert('address', address.toMap());
  }


  // Update in address table
  Future<int> updateAddress(Address address) async {
    final db = await database;
    return await db.update('address', address.toMap(),
        where: 'colAId=?', whereArgs: [address.aid]);
  }

  // Delete in address table
  Future<int> deleteAddress(Address address) async {
    final db = await database;
    return await db.delete('address',
        where: 'colAId=?', whereArgs: [address.aid]);
  }

  // Display in address table
  Future<List<Address>> fetchAddresses() async {
    final db = await database;
    List<Map> addresses = await db.query('address');
    return addresses.length == 0
    ?[]
    :addresses.map((e) => Address.fromMap(e)).toList();
  }

  Future<List<Address>> getAllAddress() async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.query('address');
    List<Address> addresses =
    allRows.map((address) => Address.fromMap(address)).toList();
    return addresses;
  }

}