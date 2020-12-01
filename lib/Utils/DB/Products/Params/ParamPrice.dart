import 'package:flutter/cupertino.dart';

class ParamPrice{
  String name;
  double price;
  ParamPrice({@required this.name, @required this.price});
  factory ParamPrice.fromJson(Map<String, dynamic> json){
    return ParamPrice(
      name: json['name'],
      price: json['price'].toDouble()
    );
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map;
    map['name'] = this.name;
    map['price'] = this.price;
    return map;
  }
}