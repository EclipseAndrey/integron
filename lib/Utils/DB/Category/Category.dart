import 'package:flutter/material.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';
class Category extends BlocSize{
  List<Color> colors;
  int icon;
  int parent;
  Category({String name, String image, int route, this.colors, this.icon, this.parent}) : super(name, 1, image, route);

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      icon: int.parse(json['icon']??25),
      name: json['name']??"null",
      image: json['image']??"",
      route: int.parse(json['id']),
      colors: json['colors']??null,
      parent: int.parse(json['parent']??"0")??0,
    );
  }
}