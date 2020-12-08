import 'package:meta/meta.dart';
import 'package:integron/Utils/DB/Products/Params/ParamPrice.dart';

class ParamsPrice{
  List<ParamPrice> params = [];
  String name;
  ParamsPrice({@required this.name, this.params});
  factory ParamsPrice.fromJson(Map<String, dynamic> json){
    return ParamsPrice(
      name: json['name'],
      params: json['params'].map((i)=>ParamPrice.fromJson(i)).toList().cast<ParamPrice>(),
    );
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map;
    map['name'] = this.name;
    map['params'] = params.map((e) => e.toMap()).toList()??[];
    return map;
  }
}