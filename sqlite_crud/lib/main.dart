import 'package:flutter/material.dart';
import 'package:sqlite_crud/models/contact.dart';
import 'package:sqlite_crud/utils/database_helper.dart';

const darkBlueColor = Color(0xff486579);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      theme: ThemeData(
        primaryColor: darkBlueColor,
      ),
      home: MyHomePage(title: 'SQLite CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  Contact _contact = Contact();
  List<Contact> _contacts = [];
  DatabaseHelper _dbHelper;
  final _ctrlName = TextEditingController();
  final _ctrlMobile = TextEditingController();

  @override
  void initState(){
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshContactList();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: darkBlueColor),
          ),
        ),
      ),
      body: Center(
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
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _ctrlName,
            decoration: InputDecoration(labelText: 'Full Name'),
            onSaved: (val) => setState(()=>_contact.name = val),
            validator: (val) => (val.length==0 ?'This field is required' :null),
          ),
        TextFormField(
          controller: _ctrlMobile,
          decoration: InputDecoration(labelText: 'Mobile Number'),
          onSaved: (val) => setState(()=>_contact.mobile = val),
          validator: (val) => (val.length<10 ?'Enter valid number' :null),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(onPressed: ()=> _onSubmit(),
            child: Text('Submit'),
            color: darkBlueColor,
            textColor: Colors.white,
          ),
        )
        ],
      ),
    ),
  );

  _refreshContactList() async{
    List<Contact> x = await _dbHelper.fetchContacts();
    setState(() {
      _contacts = x;
    });
  }

  _onSubmit() async{
      var form = _formKey.currentState;
      if (form.validate()) {
      form.save();
      if (_contact.id == null)
        await _dbHelper.insertContact(_contact);
      else
        await _dbHelper.updateContact(_contact);
      _refreshContactList();
      _resetForm();
      }
  }

  _resetForm(){
    setState(() {
      _formKey.currentState.reset();
      _ctrlName.clear();
      _ctrlMobile.clear();
      _contact.id = null;
    });
  }

  _list() => Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index){
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_circle,
                color: darkBlueColor,
                size: 40.0,
                ),
                title: Text(_contacts[index].name.toUpperCase(),
                style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(_contacts[index].mobile),
                trailing: IconButton(
                  icon: Icon(Icons.delete_sweep, color: darkBlueColor),
                  onPressed: ()async{
                    await _dbHelper.deleteContact(_contacts[index].id);
                    _resetForm();
                    _refreshContactList();
                  }),
                onTap: (){
                  setState(() {
                    _contact = _contacts[index];
                    _ctrlName.text = _contacts[index].name;
                    _ctrlMobile.text = _contacts[index].mobile;
                  });
                },
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _contacts.length,
      ),
    ),
  );
}
