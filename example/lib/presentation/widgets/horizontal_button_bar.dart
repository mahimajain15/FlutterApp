import 'package:flutter/material.dart';

class HorizontalButtonBar extends StatelessWidget {
  HorizontalButtonBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Home Page",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, '/addContactPage');
            },
            padding: EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 10.0,
            ),
            color: Colors.blueGrey,
            textColor: Colors.white,
            child: Text(
              "Person",
              style: TextStyle(
              fontSize: 20.0,
              ),
            ),
          ),),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              onPressed: (){
                Navigator.pushNamed(context, '/addCategoryPage');
              },
              padding: EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10.0,
              ),
              color: Colors.blueGrey,
              textColor: Colors.white,
              child: Text(
                "Address",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),),
        ],
      ),
    );
  }
}
