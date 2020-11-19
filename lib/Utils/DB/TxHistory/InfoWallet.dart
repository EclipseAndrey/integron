import 'package:omega_qick/Utils/fun/InitBalance.dart';

class InfoWallet{
  String balance;
  String address;

  InfoWallet({this.address,this.balance});

  factory InfoWallet.fromJson(Map<String, dynamic> json){
    return InfoWallet(
      address: json['address']== null?"":json['address'],
      balance: json['balance']== null?"0":InitBalace(json['balance']),
    );
  }
}