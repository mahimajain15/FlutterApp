import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutralike_app/utils/person_operation.dart';
import 'package:nutralike_app/utils/address_operation.dart';
import 'package:nutralike_app/models/address.dart';
import 'package:nutralike_app/models/person.dart';
import 'package:nutralike_app/display/widgets/address_dropdown.dart';

const darkBlueColor = Color(0xff486579);

class firstscreen extends StatefulWidget{
  firstscreen({Key key}): super(key: key);

  @override
  _firstscreenState createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen>{
  // int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  Person _person = Person();
  List<Person> _persons = [];
  PersonOperations personOperations = PersonOperations();
  AddressOperations addressOperations =AddressOperations();
  Address _selectedAddress;
  final _ctrlName = TextEditingController();
  final _ctrlCId = TextEditingController();
  // final _ctrlAdd = TextEditingController();
  final _ctrlUId = TextEditingController();
  final _ctrlPwd = TextEditingController();

  callback(selectedAddress){
    setState(() {
      _selectedAddress = selectedAddress;
    });
  }

  // void _incrementCounter(){
  //   setState(() {
  //     _counter++;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
          "Person Details",
          ),
        ),
      ),
      body: SingleChildScrollView(
        // alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _form(), _list()
            ],
          ),
        ),
      );
    }

  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              child: TextFormField(
                controller: _ctrlName,
                decoration: InputDecoration(labelText: 'Full Name'),
                onSaved: (val) => setState(()=>_person.name = val),
                validator: (val) => (val.length==0 ?'This field is required' :null),
              ),
            ),
            Container(
              height: 50,
              child: TextFormField(
                controller: _ctrlCId,
                decoration: InputDecoration(labelText: 'Company ID'),
                onSaved: (val) => setState(()=>_person.cid = val),
                validator: (val) => (val.length==0 ?'This field is required' :null),
              ),
            ),
            Container(
              height: 50,
              child:  FutureBuilder<List<Address>>(
                future: addressOperations.getAllAddress(),
                builder: (context, snapshot) {
                  return snapshot.hasData ? AddressDropDown(snapshot.data, callback) : Text('No address');
              },
            ),),
            Container(
              height: 50,
              child: TextFormField(
                controller: _ctrlUId,
                decoration: InputDecoration(labelText: 'User ID'),
                onSaved: (val) => setState(()=>_person.uid = val),
                validator: (val) => (val.length==0 ?'This field is required' :null),
              ),
            ),
            Container(
              height: 50,
              child: TextFormField(
                controller: _ctrlPwd,
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (val) => setState(()=>_person.password = val),
                validator: (val) => (val.length==0 ?'This field is required' :null),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(onPressed: () => _onSubmit(),
                child: Text('Save'),
                color: darkBlueColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
  );


  _onSubmit() async{
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(_person.name);
      if (_person.pid == null)
        await personOperations.insertPerson(_person);
      else
        await personOperations.updatePerson(_person);
      _refreshPersonList();
      _resetForm();
    }
  }

  _refreshPersonList() async{
    List<Person> x = await personOperations.fetchPersons();
    setState(() {
      _persons = x;
    });
  }


  _resetForm(){
    setState(() {
      _formKey.currentState.reset();
      _ctrlName.clear();
      _ctrlCId.clear();
      _ctrlUId.clear();
      _ctrlPwd.clear();
      _person.pid = null;
    });
  }

  _list() => SizedBox(
    height: 1000,
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index){
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(_persons[index].name.toUpperCase(),
                  style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.delete_sweep, color: darkBlueColor),
                    onPressed: ()async{
                      await personOperations.deletePerson(_persons[index]);
                      _resetForm();
                      _refreshPersonList();
                    }),
                onTap: (){
                  setState(() {
                    _person = _persons[index];
                    _ctrlName.text = _persons[index].name;
                    _selectedAddress.aid = _persons[index].pid;
                    _ctrlCId.text = _persons[index].cid;
                    _ctrlUId.text = _persons[index].uid;
                    _ctrlPwd.text = _persons[index].password;
                  });
                },
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _persons.length,
      ),
    ),
  );

}