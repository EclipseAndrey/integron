import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:integron/Utils/DB/Products/Params/Param.dart';
import 'package:integron/Utils/DB/Products/Params/Select.dart';

class Params extends SelectIndex{
  List<Param> params = [];
  String name;
  Params({@required this.name, this.params});
  factory Params.fromJson(Map<String, dynamic> json){
    return Params(
      name: json['name'],
      params: json['params'].map((i)=>Param.fromJson(i)).toList().cast<Param>(),
    );
  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = Map();
    map["name"] = this.name;
    map["params"] = params!=null?params.map((e) => e.toJson()).toList():jsonEncode([]);
    // map["params"] = params.map((e) => e.toMap()).toList()??[];
    return map;
  }
}