import 'package:omega_qick/Utils/DB/Errors.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/fun/InitBalance.dart';

class Balance extends Errors{
  String balance;
  String address;

  Balance({this.address,this.balance});

  Balance.err(Put put):super(put: put);

  factory Balance.fromJson(Map<String, dynamic> json){
    return Balance(
      address: json['address']== null?"":json['address'],
      balance: json['balance']== null?"0":InitBalace(json['balance']),
    );
  }
}