import 'package:flutter/cupertino.dart';
import 'package:json_serializable/json_serializable.dart';

import 'Select.dart';

part 'param.g.dart';

@JsonSerializableGenerator()
class Param extends Select{
  String name = "";

  Param({this.name});
  // factory Param.fromJson(Map<String, dynamic> json){
  //   print(json);
  //   return Param(
  //     name: json['name'],
  //   );
  // }

  factory Param.fromJson (Map<String,dynamic> json) => _$ParamListFromJson(json);

  Map<String,dynamic> toJson() => _$ParamListToJson(this);
  // Map<String,dynamic> toMap(){
  //   Map<String,dynamic> map;
  //   map["name"] = this.name;
  //   return map;
  // }

}