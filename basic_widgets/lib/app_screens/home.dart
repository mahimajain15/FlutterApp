import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(left: 10.0, top: 40.0),
            alignment: Alignment.center,
            color: Colors.deepPurple,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "A N N Y E O N G !!",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15.0,
                          fontFamily: 'OriginalSurfer',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "M A H I M A",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15.0,
                          fontFamily: 'OriginalSurfer',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Sketch",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 10.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "MMA2020",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 10.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                  ],
                ),
                Art(),
                Vote()
              ],
            )));
  }
}

class Art extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/BlackSwan.jpg');
    Image image = Image(
      image: assetImage,
      width: 300.0,
      height: 400.0,
    );
    return Container(
      child: image,
    );
  }
}

class Vote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      height: 50,
      width: 150.0,
      child: RaisedButton(
          color: Colors.amber,
          elevation: 6.0,
          child: Text("Liked it",
              style: TextStyle(
                  fontSize: 20.0, color: Colors.brown, fontFamily: 'Roboto')),
          onPressed: () => likes(context)),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  void likes(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Liked the photograph'),
      content: Text('Keep going and growing'),
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
