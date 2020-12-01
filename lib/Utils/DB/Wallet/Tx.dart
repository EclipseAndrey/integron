import 'package:omega_qick/Pages/Login2/ButtonNext.dart';

class Tx {
  String date;
  String face;
  int type;
  int status;
  String currency = "DEL";
  String hash;
  String amount;


  Tx({
    this.type,
    this.status,
    this.date,
    this.currency,
    this.face,
    this.hash,
    this.amount,

});

  factory Tx.fromJson(Map<String, dynamic> json){
    return Tx(
      date: json['date']== null?"":json['date'],
      face: json['recipient']== null?"":json['recipient'],
      type: json['type']== null?1:int.parse(json['type'].toString()),
      amount: json['amount']== null?"":json['amount'],
      status: json['status']== null?"":int.parse(json['status']),
      hash: json['hash']== null?"":json['hash'],
      currency: "DEL"
    );
  }
}