import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/CategoryPath.dart';
import 'package:omega_qick/Utils/DB/Items/Counter.dart';
import 'package:omega_qick/Utils/DB/Items/Property.dart';
import 'package:omega_qick/Utils/DB/Items/TokenAbstract.dart';
import 'package:omega_qick/Utils/DB/Params/Param.dart';
import 'package:omega_qick/Utils/DB/Params/Params.dart';
import 'package:omega_qick/Utils/DB/Params/ParamsPrice.dart';

class ProductShort extends BlocSize with Counter, TokenParam{
  String text;
  double price;
  String sale;


  ProductShort({
    String name,
    String image,
    int route,
    this.text,
    this.price,
    this.sale,

  }) : super(name, 2, image, route);


  ProductShort.error(int error) : super.error(error);

  factory ProductShort.fromJson(Map<String, dynamic> json){
    return ProductShort(
      name: json['name']??"null",
      image: json['image'],
      route: int.parse(json['route']),
      text: json['text'],
      price: double.parse(json['price']),
      sale: json['sale'].toString()??"",
    );
  }
}

class Product extends ProductShort {

  List<dynamic> images;
  int type;
  String unit;
  List<Property> property;
  String delivery;
  String address;
  int owner;
  int likeCount;
  String fullText;
  int available;
  int itemCount;
  List<dynamic> catPath;
  List<dynamic> detail;
  String ownerName;
  List<Params> params = [];
  ParamsPrice paramsPrice;
  int cat;

  Product({
    @required String name,
    @required String image,
    @required int route,
    @required String text,
    @required double price,
    String sale,

    @required this.images,
    bool full,
    this.address,
    this.available,
    @required this.delivery,
    @required this.fullText,
    this.itemCount,
    this.likeCount,
    @required this.owner,
    @required this.ownerName,
    @required this.property,
    @required this.type,
    @required  this.unit,
    @required this.catPath,
    @required this.detail,

    this.params,
    this.paramsPrice,
    this.cat,
}) : super(name: name, image: image, route:route, text: text, price:price, sale:sale??"");

  factory Product.fromJson(Map<String, dynamic> jsonC){
    print(jsonC['params']);
    return Product(
      full: true,
      name: jsonC['name'],
      ownerName: jsonC['ownername'],
      image: jsonC['image'],
      images: jsonC['images'],
      detail: jsonC['detail'],
      route: int.parse(jsonC['route']),
      text: jsonC['text'],
      price: double.parse(jsonC['price']),
      sale: jsonC['sale'].toString()??"",
      unit: jsonC['unit'],
      property: jsonC['property'] == null?[]:jsonC['property'].map((i){return Property.fromJson(i);}).toList().cast<Property>(),
      fullText: jsonC['fulldesc'],
      delivery: jsonC['delivery'],
      address: jsonC['address'],
      owner: int.parse(jsonC['owner']),
      likeCount: int.parse(jsonC['likecount']),
      available: int.parse(jsonC['available']),
      itemCount: int.parse(jsonC['itemcount']),
      type: int.parse(jsonC['type']),
      catPath: jsonC['cat'].map((i)=>CategoryPath.fromJson(i)).toList(),
      params: jsonC['']== null?[]:jsonC['params'].map((i) => Params.fromJson(i)).toList().cast<Params>(),
      paramsPrice: jsonC['paramswithprice']== null?null:ParamsPrice.fromJson(jsonC['paramswithprice']),

    );

  }


  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["name"] = name;
    map["images"] = images as List<String>;
    map["detail"] = [];
    map["text"] = text;
    map["price"] = price.toString();
    map["unit"] = unit;
    map["fulldesc"] = fullText;
    map["delivery"] = "1";
    map["address"] = address;
    map["available"] = "true";
    map["type"] = type.toString();
    map["cat"] = cat.toString();
    map["params"] = params??params.map((i) => i.toMap());
    map["property"] = property??property.map((i) => i.toMap().toString());
    map['token'] = token??"";
    return map;
  }


  Product.error(int error) : super.error(error);

}


