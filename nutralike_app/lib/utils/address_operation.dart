import 'package:nutralike_app/utils/database_helper.dart';
import 'package:nutralike_app/models/address.dart';

class AddressOperations {
  AddressOperations addressOperations;

  final dbProvider = DatabaseRepository.instance;

  // Insert in address table
  Future<int> insertAddress(Address address) async {
    final db = await dbProvider.database;
    return await db.insert('address', address.toMap());
  }

  // Update in address table
  Future<int> updateAddress(Address address) async {
    final db = await dbProvider.database;
    return await db.update('address', address.toMap(),
        where: 'colAId=?', whereArgs: [address.aid]);
  }

  // Delete in address table
  Future<int> deleteAddress(Address address) async {
    final db = await dbProvider.database;
    return await db.delete('address',
        where: 'colAId=?', whereArgs: [address.aid]);
  }

  // Display in address table
  Future<List<Address>> fetchAddresses() async {
    final db = await dbProvider.database;
    List<Map> addresses = await db.query('address');
    return addresses.length == 0
    ?[]
    :addresses.map((e) => Address.fromMap(e)).toList();
  }

  Future<List<Address>> getAllAddress() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.query('address');
    List<Address> addresses =
    allRows.map((address) => Address.fromMap(address)).toList();
    return addresses;
  }
}