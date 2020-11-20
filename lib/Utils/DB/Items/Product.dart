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
  int ownerIdS;


  ProductShort({
    String name,
    String image,
    int route,
    this.text,
    this.price,
    this.sale,
    this.ownerIdS

  }) : super(name, 2, image, route);


  ProductShort.error(int error) : super.error(error);

  factory ProductShort.fromJson(Map<String, dynamic> json){
    return ProductShort(
      name: json['name']??"null",
      image: json['image'],
      route: int.parse(json['route']),
      text: json['text'],
      price: double.parse(json['price']),
      ownerIdS: int.parse(json['ownerid']),
      sale: json['sale'].toString()??"",
    );
  }
}

class Product extends ProductShort {

  List<String> images;
  int type = 0;
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
  int pozition = 0;

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
    this.pozition,
}) : super(name: name, image: image, route:route, text: text, price:price, sale:sale??"");

  factory Product.fromJson(Map<String, dynamic> jsonC){
    print("tope parse "+ int.parse(jsonC['type']).toString());
    try {
      return Product(
        full: true,
        name: jsonC['name'] == null?"":jsonC['name'],
        ownerName: jsonC['ownername'] == null? "":jsonC['ownername'] ,
        image: jsonC['image'] == null? "":jsonC['image'],
        images: jsonC['images'] == null?[]:jsonC['images'].map((i)=>i).toList().cast<String>(),
        detail: jsonC['detail'] == null?[]:[],
        route: int.parse(jsonC['route'] == null?"0":jsonC['route']),
        pozition: int.parse(jsonC['pozition'] == null?"0":jsonC['pozition']),
        text: jsonC['text'] == null? "":jsonC['text'],
        price: double.parse(jsonC['price'] == null?"0":jsonC['price']),
        sale: jsonC['sale'].toString() == "null"? "":jsonC['sale'].toString(),
        unit: jsonC['unit'] == null?"unit":jsonC['unit'],
        property: jsonC['property'] == null ? [] : jsonC['property'].map((i) {
          return Property.fromJson(i);
        }).toList().cast<Property>(),
        fullText: jsonC['fulldesc'] == null?"":jsonC['fulldesc'],
        delivery: jsonC['delivery'] == null?"1":jsonC['delivery'],
        address: jsonC['address'] == null?"":jsonC['address'],
        owner: int.parse(jsonC['owner'] == null?"0":jsonC['owner'] ),
        likeCount: int.parse(jsonC['likecount'] == null?"0":jsonC['likecount']),
        available: int.parse(jsonC['available'] == null?"0":jsonC['available']),
        itemCount: int.parse(jsonC['itemcount'] == null?"0":jsonC['itemcount']),
        type: int.parse(jsonC['type']== null?"0":jsonC['type']),
        catPath: jsonC['cat']== null?[]:jsonC['cat'].map((i) => CategoryPath.fromJson(i)).toList(),
        params: jsonC['params'] == null ? [] : jsonC['params'].map((i) => Params.fromJson(i)).toList().cast<Params>(),
       // paramsPrice: jsonC['paramswithprice'] == null ? [] : ParamsPrice.fromJson(jsonC['paramswithprice']),

      );
    }catch(e){
      print(e);
      return null;
    }

  }


  Map<String, dynamic> toJson() {

    Map<String, dynamic> step= Map();
    step['code']=property == null?"":property.map((e) => e.toJson()).toList();

    final map = Map<String, dynamic>();
    map["name"] = name;
    map["images"] = images;
    map["detail"] = "";
    map["shortdesc"] = text;
    map["price"] = price.toString();
    map["unit"] = unit;
    map["fulldesc"] = fullText;
    map["delivery"] = "1";
    map["address"] = address;
    map["available"] = "1";
    map["type"] = type.toString();
    map["cat"] = cat.toString();
    map["params"] = params != null?params.map((i)=>i.toJson()).toList():"";
    map["property"] = step;
    map['token'] = token??"";
    map['id'] = route;
    return map;
  }


  Product.error(int error) : super.error(error);

}


