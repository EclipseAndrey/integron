import 'package:flutter/cupertino.dart';
import 'package:omega_qick/Errors.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';

class Business extends Errors{

  List<Product> products = [];
  String nameBusiness;
  String nameOwner;
  String textShort;
  Business({
    @required this.textShort,
    @required this.nameBusiness,
    @required this.nameOwner,
    @required  this.products,
});

  factory Business.fromJson(Map<String, dynamic> json){
    print(json);
    return Business(
      //todo Проверить ключи
      textShort: json[''],
      nameBusiness: json['bizname'],
      nameOwner: json['nameOwner'],
      products: json['products']==null?[]:json['products'].map((i)=>Product.fromJson(i)).toList().cast<Product>()
    );
  }

  Business.error():super(error: true);

}