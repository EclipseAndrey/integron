import 'package:flutter/material.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/Counter.dart';
import 'package:integron/Utils/DB/Products/Params/Params.dart';
import 'package:integron/Utils/DB/Products/Params/ParamsPrice.dart';
import 'package:integron/Utils/DB/Products/Property.dart';
import 'package:integron/Utils/DB/Products/TokenAbstract.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';
import 'package:integron/Utils/DB/Put.dart';

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

  bool check;
  Put errors;
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
  List<String> details;
  String ownerName;
  List<Params> params = [];
  ParamsPrice paramsPrice;
  Category cat;
  int pozition = 0;
  String accountName;
  String accountSecretKey;
  String offerCode;
  int hidden;
  bool isFavorite;


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
    @required this.details,

    this.params,
    this.paramsPrice,
    this.cat,
    this.pozition,
    this.check,
    this.accountName,
    this.accountSecretKey,
    this.offerCode,
    this.hidden,
    this.isFavorite,


}) : super(name: name, image: image, route:route, text: text, price:price, sale:sale??"");

  Product.err(this.errors);


  factory Product.fromJson(Map<String, dynamic> jsonC){
     print("tope parse "+ jsonC['image'].toString());
    // try {
      return Product(
        full: true,


        name: jsonC['name'] == null?"":jsonC['name'],
        ownerName: jsonC['ownername'] == null? "":jsonC['ownername'] ,
        image: jsonC['image'] == null? "":jsonC['image'],
        images: jsonC['images'] == null?[]:jsonC['images'].map((i)=>i).toList().cast<String>(),
        details: jsonC['detail'] == null?[]:jsonC['detail'].map((i) =>i).toList().cast<String>(),
        route: int.parse(jsonC['route'] == null?"0":jsonC['route']),
        pozition: int.parse(jsonC['pozition'] == null?"0":jsonC['pozition']),
        text: jsonC['shortdesc'] == null? "":jsonC['shortdesc'],
        price: double.parse(jsonC['price'] == null?"0":jsonC['price']),
        sale: jsonC['sale'].toString() == "null"? "":jsonC['sale'].toString(),
        unit: jsonC['unit'] == null?"unit":jsonC['unit'],
        property: jsonC['property'] == null ? [] : jsonC['property'].map((i) {
          return Property.fromJson(i);
        }).toList().cast<Property>(),
        fullText: jsonC['text'] == null?"":jsonC['text'],
        delivery: jsonC['delivery'] == null?"1":jsonC['delivery'],
        address: jsonC['address'] == null?"":jsonC['address'],
        owner: int.parse(jsonC['owner'] == null?"0":jsonC['owner'] ),
        likeCount: int.parse(jsonC['likecount'] == null?"0":jsonC['likecount']),
        available: int.parse(jsonC['available'] == null?"0":jsonC['available']),
        itemCount: int.parse(jsonC['itemcount'] == null?"0":jsonC['itemcount']),
        type: int.parse(jsonC['type']== null?"0":jsonC['type']),
        catPath: jsonC['cat']== null?[]:jsonC['cat'].map((i) => Category.fromJson(i)).toList(),
        params: jsonC['params'] == null ? [] : jsonC['params'].map((i) => Params.fromJson(i)).toList().cast<Params>(),
        cat: Category.fromJson(jsonC['cat'][0]),
       // paramsPrice: jsonC['paramswithprice'] == null ? [] : ParamsPrice.fromJson(jsonC['paramswithprice']),
        check: true,
        hidden: jsonC['view'] == null ?0:int.parse(jsonC['view']),
        isFavorite: jsonC['isfavorite'] == null? false:jsonC['isfavorite'],


      );
    // }catch(e){
    //   print(e);
    //   return null;
    // }

  }


  Map<String, dynamic> toJson() {

    Map<String, dynamic> step= Map();
    step['code']=property == null?"":property.map((e) => e.toJson()).toList();

    final map = Map<String, dynamic>();
    map["name"] = name;
    map["images"] = images;
    map["shortdesc"] = text;
    map["price"] = price.toString();
    map["unit"] = unit;
    map["fulldesc"] = fullText;
    map["delivery"] = "1";
    map["address"] = address;
    map["available"] = delivery;
    map["type"] = type.toString();
    map["cat"] = cat.route.toString();
    map["params"] = params != null?params.map((i)=>i.toJson()).toList():"";
    map["property"] = step;
    map['token'] = token??"";
    map['id'] = [route];
    map['accountname'] = accountName;
    map['accountkey'] = accountSecretKey;
    map['producttitle'] = name;
    map['offercode'] = offerCode;
    map['detail'] = details;
    return map;
  }


  Product.error(int error) : super.error(error);

}


