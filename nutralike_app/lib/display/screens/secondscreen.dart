import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutralike_app/models/address.dart';
import 'package:nutralike_app/utils/address_operation.dart';

const darkBlueColor = Color(0xff486579);

class secondscreen extends StatefulWidget{
  secondscreen({Key key}): super(key: key);
  @override
  _secondscreenState createState() => _secondscreenState();
}

class _secondscreenState extends State<secondscreen>{
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  Address _address = Address();
  List<Address> _addresses = [];
  AddressOperations addressOperations =AddressOperations();
  final _ctrlSt1 = TextEditingController();
  final _ctrlSt2 = TextEditingController();
  final _ctrlCity = TextEditingController();
  final _ctrlState = TextEditingController();
  final _ctrlZip = TextEditingController();
  final _ctrlCnt = TextEditingController();

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Address Details",
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
              controller: _ctrlSt1,
              decoration: InputDecoration(labelText: 'Street Line 1'),
              onSaved: (val) => setState(()=>_address.stL1 = val),
              validator: (val) => (val.length==0 ?'This field is required' :null),
            ),
          ),
          Container(
            height: 50,
            child: TextFormField(
              controller: _ctrlSt2,
              decoration: InputDecoration(labelText: 'Street Line 2'),
              onSaved: (val) => setState(()=>_address.stL2 = val),
              validator: (val) => (val.length==0 ?'This field is required' :null),
            ),
          ),
          Container(
            height: 50,
            child: TextFormField(
              controller: _ctrlCity,
              decoration: InputDecoration(labelText: 'City'),
              onSaved: (val) => setState(()=>_address.city = val),
              validator: (val) => (val.length==0 ?'This field is required' :null),
            ),
          ),
          Container(
            height: 50,
            child: TextFormField(
              controller: _ctrlState,
              decoration: InputDecoration(labelText: 'State'),
              onSaved: (val) => setState(()=>_address.state = val),
              validator: (val) => (val.length==0 ?'This field is required' :null),
            ),
          ),
          Container(
            height: 50,
            child: TextFormField(
              controller: _ctrlZip,
              decoration: InputDecoration(labelText: 'Zip Code'),
              onSaved: (val) => setState(()=>_address.zip = val),
              validator: (val) => (val.length==0 ?'This field is required' :null),
            ),
          ),
          Container(
            height: 50,
            child: TextFormField(
              controller: _ctrlCnt,
              decoration: InputDecoration(labelText: 'Country'),
              onSaved: (val) => setState(()=>_address.cnt = val),
              validator: (val) => (val.length==0 ?'This field is required' :null),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(onPressed: ()=> _onSubmit(),
              child: Text('Save'),
              color: darkBlueColor,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    ),
  );



  _onSubmit() async{
    var form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      // print(_person.name);
      if (_address.aid == null)
        await addressOperations.insertAddress(_address);
      else
        await addressOperations.updateAddress(_address);
      _refreshAddressList();
      _resetForm();
    }
  }

  _refreshAddressList() async{
    List<Address> x = await addressOperations.fetchAddresses();
    setState(() {
      _addresses = x;
    });
  }

  _resetForm(){
    setState(() {
      _formKey.currentState.reset();
      _ctrlSt1.clear();
      _ctrlSt2.clear();
      _ctrlCity.clear();
      _ctrlState.clear();
      _ctrlZip.clear();
      _ctrlCnt.clear();
      _address.aid = null;
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
                title: Text(_addresses[index].city.toUpperCase(),
                  style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.delete_sweep, color: darkBlueColor),
                    onPressed: ()async{
                      await addressOperations.deleteAddress(_addresses[index]);
                      _resetForm();
                      _refreshAddressList();
                    }),
                onTap: (){
                  setState(() {
                    _address = _addresses[index];
                    _ctrlSt1.text = _addresses[index].stL1;
                    _ctrlSt2.text = _addresses[index].stL2;
                    _ctrlCity.text = _addresses[index].city;
                    _ctrlState.text = _addresses[index].state;
                    _ctrlZip.text = _addresses[index].zip;
                    _ctrlCnt.text = _addresses[index].cnt;
                  });
                },
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _addresses.length,
      ),
    ),
  );

}