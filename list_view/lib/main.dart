import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Exploring lists in flutter",
    home: Scaffold(
      appBar: AppBar(title: Text('Basic list view'),),
      body: getListView(),
    ),
  ));
}

Widget getListView(){
  var listView = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.landscape),
        title: Text('Landscape'),
        subtitle: Text('Beautiful View'),
        trailing: Icon(Icons.wb_sunny),
        onTap: (){
          debugPrint('Landscape tapped');
        },
      ),
      ListTile(
        leading: Icon(Icons.laptop_chromebook),
        title: Text('Windows'),
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text('Phone'),
      ),
      Text("Another line in widget"),

      Container(color: Colors.blueGrey, height: 50.0,)
    ],
  );
  return listView;
}