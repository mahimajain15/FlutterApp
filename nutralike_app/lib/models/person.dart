class Person{

  int pid;
  String name;
  String cid;
  String uid;
  String password;
  int add;

  Person({this.pid, this.name, this.cid, this.uid, this.password, this.add});

  Person.fromMap(dynamic map){
    this.pid = map['colPId'];
    this.name = map['colName'];
    this.cid = map['colCId'];
    this.uid = map['colUId'];
    this.password = map['colPwd'];
    // this.address = map['colAdd'];
    this.add = map['FK_Person_Address'];
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'colName': name,
      'colCId': cid,
      'colUId': uid,
      'colPwd': password,
      'FK_Person_Address': add
    };

    if(pid != null)
      map['colPId'] = pid;
    return map;
  }
}