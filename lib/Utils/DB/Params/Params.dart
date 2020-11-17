import 'package:meta/meta.dart';
import 'package:omega_qick/Utils/DB/Params/Param.dart';
import 'package:omega_qick/Utils/DB/Params/Select.dart';

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
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map;
    map["name"] = this.name;
    map["params"] = params.map((e) => e.toMap())??[];
    // map["params"] = params.map((e) => e.toMap()).toList()??[];
    return map;
  }



}