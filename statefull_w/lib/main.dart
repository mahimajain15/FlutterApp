import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Stateful App Example",
      home: FavoriteCity(),
    )
  );
}

class FavoriteCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity>{
  String nameCity = '';
  var _currencies = ['Rupees', 'Won', 'Dollars', 'Others'];
  var _currentItemSelected = 'Rupees';
  @override
  Widget build(BuildContext context) {

    debugPrint("Favorite City widget is created");

    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful App Example'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              // onSubmitted: (String userInput){ //changes reflect after pressing enter
              onChanged: (String userInput){ //changes reflect during entering the text
                setState(() {
                  debugPrint("set State is called, this tells framework to redraw the FavoriteCity widget");
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>
              (items: _currencies.map((String dropDownStringItem){
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                );
            }).toList(),

            onChanged: (String newValueSelected){
                _dropDownItemSelected(newValueSelected);
            },
              value: _currentItemSelected,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                "Your best city is $nameCity",
              style: TextStyle(fontSize: 20.0),
            ))
          ],
        ),
      ),
    );
  }
  void _dropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

}