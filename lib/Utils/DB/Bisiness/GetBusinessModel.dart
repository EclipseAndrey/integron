import 'package:flutter/cupertino.dart';
import 'package:omega_qick/Errors.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';

class Business extends Errors{

  List<Product> products = [];
  String nameBusiness;
  String nameOwner;
  String textShort;
  String photo;
  Business({
    @required this.photo,
    @required this.textShort,
    @required this.nameBusiness,
    @required this.nameOwner,
    @required  this.products,
});

  factory Business.fromJson(Map<String, dynamic> json){

      return Business(
        //todo Проверить ключи
          photo: json["bizphoto"],
          textShort: json['textShort'] == null ? null : json['textShort'].toString().length == 0 ? null : json['textShort'],
          nameBusiness: json['bizname'] == null ? null : json['bizname'].toString().length == 0 ? null : json['bizname'],
          nameOwner: json['nameOwner'] ?? "null",
          products: json['products'] == null ? [] : json['products'].map((i) => Product.fromJson(i)).toList().cast<Product>()
      );


  }

  Business.error():super(error: true);

}