import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutralike_app/models/address.dart';

class AddressDropDown extends StatefulWidget {
  List<Address> addresses;
  Function(Address) callback;

  AddressDropDown(
      this.addresses,
      this.callback, {
        Key key,
      }) : super(key: key);

  @override
  _AddressDropDownState createState() => _AddressDropDownState();
}

class _AddressDropDownState extends State<AddressDropDown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Address>(
        hint: Text('Select Address'),
        onChanged: (Address value){
          setState(() {
            widget.callback(value);
          });
        },
        items: widget.addresses.map((address) {
          return DropdownMenuItem<Address>(
            value: address,
            child: Text(address.stL1),
          );
        }).toList(),

    );
  }
}