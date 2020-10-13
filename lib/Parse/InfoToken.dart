import 'package:omega_qick/Authorization/WalletDB.dart';

class InfoToken{
  int code = 0;
  String num;
  String token;
  String name;
  int rules;
  String photo;
  List<WalletData> wallets;
  InfoToken({this.code,this.num,this.name,this.photo,this.wallets,this.rules,this.token});
  factory InfoToken.fromJson(Map<String, dynamic> json){
    return InfoToken(
      code: json['code'],
      num: json['num'],
      token: json['token'],
      name: json['name'],
      rules: json['rules'],
      photo: json['photo'],
      wallets: json['wallets']!= null? json['wallets'].map((i) => WalletData.fromMap(i)):null,

    );
  }



}