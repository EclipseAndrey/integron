
import 'package:omega_qick/Utils/DB/WalletDB.dart';

class InfoToken{
  int code = 0;
  String num;
  String token;
  String name;
  int role;
  String address;

  String photo;
  InfoToken({this.code,this.num,this.name,this.photo,this.role,this.token, this.address});
  factory InfoToken.fromJson(Map<String, dynamic> json){
    InfoToken out = InfoToken(
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