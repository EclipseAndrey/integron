import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Parse/tx.dart';
import 'Parse/txs.dart';


class Balance {
  String del;
  Balance({this.del});

  factory Balance.fromJson(Map<String, dynamic> json){
    return Balance(
      del: json['del'] == null? "0":json['del']
    );
  }
}

class Address {
  // final int id;
  final String address;
  final Balance balance;
  List<dynamic> txs;
  Address({/*this.id,*/ this.address, this.balance, this.txs});

  factory Address.fromJson(Map<String, dynamic> json) {
    print("==bal== "+json['balance'].toString());
    // print(""json['txt']);
    return Address(
        // id: json['id'] == null? 0:json['id'],
        address: json['address'],
        balance: Balance.fromJson(json['balance']) == null? Balance(del: "000000000000000"):Balance.fromJson(json['balance']),
        txs: json['txs'].map((i) => Tx.fromJson(i)).toList(),
    );
  }
}

class Result {
  Address address;
  Result({this.address});
  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      address: Address.fromJson(json['address']),
    );
  }
}

class User {
  Result result;
  bool ok;
  User({this.result, this.ok});

  bool errors = false;
  User.error(){errors = true;}

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      ok: json['ok'],
      result: Result.fromJson(json['result']),
    );
  }
}

