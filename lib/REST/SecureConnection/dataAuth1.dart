class DataAuth1{
  int code;
  int pubKey;
  int partKey;
  DataAuth1({this.code,this.pubKey,this.partKey});

  factory DataAuth1.fromJson(Map<String, dynamic> json){
    return DataAuth1(
      code: json['code'],
      pubKey: json['pubkey'],
      partKey: int.parse(json['partkey']),
    );
  }

}