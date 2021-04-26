import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Exploring Long List",
    home: Scaffold(
      appBar: AppBar(title: Text('Long list'),),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB clicked');
        },
        child: Icon(Icons.add),
        tooltip: 'Add one more item', //when we long press the button this message will appear
      ),
    ),
  ));
}

void showSnackBar(BuildContext context, String item){
  var snackBar = SnackBar(
      content: Text('You just tapped the $item'),
    action: SnackBarAction(
      label: "UNDO",
      onPressed: (){
        debugPrint('Performing dummy UNDO operation');
      },
    ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

//created long list here
List<String> getListElements(){
  var items = List<String>.generate(10, (counter) => 'Item $counter');
  return items;
}

Widget getListView(){
  var listItems = getListElements();
  var listView = ListView.builder(
      itemBuilder: (context, index){
        return ListTile(
          leading: Icon(Icons.arrow_right),
          title: Text(listItems[index]),
          onTap: (){
            showSnackBar(context, listItems[index]);
          },
        );
      });
  return listView;
}