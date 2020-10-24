class DataAuth2{
  int code;
  DataAuth2({this.code});
  factory DataAuth2.fromJson(Map<String, dynamic> json){
    return DataAuth2(
      code: json['code'],
    );
  }

}