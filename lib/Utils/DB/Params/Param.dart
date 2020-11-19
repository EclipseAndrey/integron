import 'package:flutter/cupertino.dart';

import 'Select.dart';

class Param extends Select{
  String name = "";

  Param({this.name});
  factory Param.fromJson(Map<String, dynamic> json){
    print(json);
    return Param(
      name: json['name'],
    );
  }


  // Map<String,dynamic> toJson() => _$ParamListToJson(this);
  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = Map();
    map['name'] = this.name;
    return map;
  }

  // Map toJson(){
  //   return {"name" : name};
  // }


}