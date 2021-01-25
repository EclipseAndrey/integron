import 'package:flutter/material.dart';

class ItemModel{
  final String name;
  final String urlImage;
  final String urlAvatar;
  final String location;
  final Size size;
  final Specification specification;

  ItemModel({
    @required this.name,
    @required this.urlImage,
    @required this.urlAvatar,
    @required this.location,
    @required this.size,
    @required this.specification
  });
}

class Specification{
  final String model;
  final int iso;
  final double aperture;
  final double focusLength;
  final String exposure;


  Specification({
    @required  this.iso,
    @required this.aperture,
    @required this.exposure,
    @required this.focusLength,
    @required this.model
  });

}

Future<List<ItemModel>> getList()async{
  return Future.delayed(Duration(milliseconds: 1000), ()=>_out);
}
