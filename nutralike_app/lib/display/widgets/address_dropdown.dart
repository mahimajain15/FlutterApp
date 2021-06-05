import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutralike_app/models/address.dart';

class AddressDropDown extends StatefulWidget {
  List<Address> addresses;

  AddressDropDown(
      this.addresses,
      {
        Key key,
      }) : super(key: key);
  @override
  _AddressDropDownState createState() => _AddressDropDownState();
}

class _AddressDropDownState extends State<AddressDropDown> {
var _item;

// var holder = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DropdownButton<Address>(
          value: _item,
          onChanged: (value){
            setState(() {
              _item = value;
            });
          },
          hint: Text('Select Address'),
          items: widget.addresses.map((address) {
            return DropdownMenuItem<Address>(
              value: address,
              child: Text(address.stL1),
            );
          }).toList(),

      )
    );
  }
}


// child: RichText(
//   // overflow: TextOverflow.clip,
//   // TextOverflow overflow = TextOverflow.clip,
//   text: TextSpan(
//       children: <TextSpan>[
//         TextSpan(text: address.stL1),
//         TextSpan(text: ', '),
//         TextSpan(text: address.stL2),
//         TextSpan(text: ', '),
//         TextSpan(text: address.city),
//         TextSpan(text: ', '),
//         TextSpan(text: address.state),
//         TextSpan(text: ', '),
//         TextSpan(text: address.zip),
//         TextSpan(text: ', '),
//         TextSpan(text: address.cnt),
//       ]),),