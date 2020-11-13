import 'package:flutter/cupertino.dart';

class Param{
  String name = "";

  Param({@required this.name});
  factory Param.fromJson(Map<String, dynamic> json){
    return Param(
      name: json['name'],
    );
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map;
    map['name'] = this.name;
    return map;
  }

}