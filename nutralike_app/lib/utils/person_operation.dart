import 'package:nutralike_app/utils/database_helper.dart';
import 'package:nutralike_app/models/person.dart';
import 'package:nutralike_app/models/address.dart';

class PersonOperations {
  PersonOperations personOperations;

  final dbProvider = DatabaseRepository.instance;

  // Insert in person table
  insertPerson(Person person) async{
    final db = await dbProvider.database;
    db.insert('person', person.toMap());
    print('person details inserted');
  }

  // Update in person table
  updatePerson(Person person) async{
    final db = await dbProvider.database;
    db.update('person', person.toMap(),
        where: 'colPId=?', whereArgs: [person.pid]);
  }

  // Delete in person table
  deletePerson(Person person) async{
    final db = await dbProvider.database;
    db.delete('person',
        where: 'colPId=?', whereArgs: [person.pid]);
  }

  // Display in person table
  Future<List<Person>> fetchPersons() async{
    final db = await dbProvider.database;
    List<Map> persons= await db.query('person');
    return persons.length==0
    ?[]
    :persons.map((e) => Person.fromMap(e)).toList();
  }

  Future<List<Person>> getAllPerson() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.query('person');
    List<Person> persons =
    allRows.map((person) => Person.fromMap(person)).toList();
    return persons;
  }

  Future<List<Person>> getAllPersonByAddress(Address address) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.rawQuery('''
    SELECT * FROM person 
    WHERE contact.FK_contact_category = ${address.aid}
    ''');
    List<Person> persons =
    allRows.map((person) => Person.fromMap(person)).toList();
    return persons;
  }


}