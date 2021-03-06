import 'dart:io';

import 'package:integron/Utils/DB/Errors.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/main.dart';

class InfoToken extends Errors{
  int id;
  int code = 0;
  String num;
  String token;
  String name;
  int role;
  String address;

  String photo;
  InfoToken({this.code,this.num,this.name,this.photo,this.role,this.token, this.address,this.id});

  InfoToken.err(Put put){
    put = put;
  }

  factory InfoToken.fromJson(Map<String, dynamic> json){
    if(json['root'] != null ){FullVersion = json['root'];}
    if(Platform.isAndroid){FullVersion = true;}
    InfoToken out = InfoToken(
      id: int.parse((json['id']??"0").toString()),
      code: json['code'],
      address: json['address']??null,
      num: json['num'].toString(),
      token: json['token'],
      name: json['name']??null,
      role: json['role'],
      photo: json['photo'] == null?null:json['photo']==""?null:json['photo']==" "?null:json['photo'],
    );
    return out;
  }
}