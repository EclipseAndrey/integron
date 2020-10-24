import 'package:omega_qick/Authorization/WalletDB.dart';

class InfoToken{
  int code = 0;
  String num;
  String token;
  String name;
  int role;
  String photo;
  List<dynamic> wallets;
  InfoToken({this.code,this.num,this.name,this.photo,this.wallets,this.role,this.token});
  factory InfoToken.fromJson(Map<String, dynamic> json){
    InfoToken out = InfoToken(
      code: json['code'],
      num: json['num'].toString(),
      token: json['token'],
      name: json['name'],
      role: json['role'],
      photo: json['photo'],
      wallets: json['wallets']!= null? json['wallets'].map((i) => WalletData.fromJson(i)).toList():null,
    );
    return out;
  }



}