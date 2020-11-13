import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/CategoryPath.dart';
import 'package:omega_qick/Utils/DB/Items/Counter.dart';
import 'package:omega_qick/Utils/DB/Items/Property.dart';

class ProductShort extends BlocSize with Counter{
  String text;
  int price;
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
      name: json['name'],
      image: json['image'],
      route: int.parse(json['route']),
      text: json['text'],
      price: int.parse(json['price']),
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

  Product({
    @required String name,
    @required String image,
    @required int route,
    @required String text,
    @required int price,
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
    @required this.detail
}) : super(name: name, image: image, route:route, text: text, price:price, sale:sale??"");

  factory Product.fromJson(Map<String, dynamic> jsonC){
    return Product(
      full: true,
      name: jsonC['name'],
      ownerName: jsonC['ownername'],
      image: jsonC['image'],
      images: jsonC['images'],
      detail: jsonC['detail'],
      route: int.parse(jsonC['route']),
      text: jsonC['text'],
      price: int.parse(jsonC['price']),
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
    );
  }

  Product.error(int error) : super.error(error);

}


