import 'dart:math';
import "package:flutter/material.dart";
import 'package:flutter_app/main.dart';

void main() => runApp(new MyFlutterApp());

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.deepPurple,
      child: Center(
        child: Text(
          generateLuckyNumber(),
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
  String generateLuckyNumber() {
    var random = Random();
    int luckyNumber = random.nextInt(10);

    return "Annyeong !! \n Your lucky number is :: $luckyNumber";
}