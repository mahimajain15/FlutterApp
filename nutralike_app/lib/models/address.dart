class Address{

  int aid;
  String stL1;
  String stL2;
  String city;
  String state;
  String zip;
  String cnt;

  Address({
    this.aid,
    this.stL1,
    this.stL2,
    this.city,
    this.state,
    this.zip,
    this.cnt
  });

  Address.fromMap(dynamic map){
    this.aid = map['colAId'];
    this.stL1 = map['colSt1'];
    this.stL2 = map['colSt2'];
    this.city = map['colCity'];
    this.state = map['colState'];
    this.zip = map['colZip'];
    this.cnt = map['colCnt'];
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'colSt1': stL1,
      'colSt2': stL2,
      'colCity': city,
      'colState': state,
      'colZip': zip,
      'colCnt': cnt
    };

    if(aid != null)
      map['colAId'] = aid;
    return map;
  }
}