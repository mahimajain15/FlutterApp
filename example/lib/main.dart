import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/presentation/pages/add_category_page.dart';
import 'package:sqflite_tutorial/presentation/pages/add__person_page.dart';
import 'package:sqflite_tutorial/presentation/pages/contacts_page.dart';
import 'package:sqflite_tutorial/presentation/pages/edit_contact_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/homePage': (context) => ContactsPage(),
        '/addPersonPage': (context) => AddPersonPage(),
        '/edit': (context) => EditContactPage(),
        '/addCategoryPage': (context) => AddCategoryPage(),
      },
      home: ContactsPage(),
    );
  }
}
