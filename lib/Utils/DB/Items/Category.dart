import 'package:flutter/material.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';

class Category extends BlocSize{
  List<Color> colors;
  int icon;
  Category({String name, String image, int route, this.colors, this.icon}) : super(name, 1, image, route);

  factory Category.fromJson(Map<String, dynamic> json){
    print("Парсинг "+ json.toString());
    //todo Парсинг нужно настроить
    return Category(
      icon: int.parse(json['icon']),
      name: json['name'],
      image: json['image'],
      route: int.parse(json['route']),
      colors: json['colors']??null,
    );
  }
}