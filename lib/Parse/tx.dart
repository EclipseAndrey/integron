import 'package:omega_qick/Parse/txData.dart';

import 'Fee.dart';

class Tx {

  String name;
  int id;
  String hash;
  String timestamp;
  String status;
  String type;
  Fee fee;
  String message;
  int blockId;
  String from;
  String to;
  TxData data;


  Tx({
    this.id,
    this.hash,
    this.timestamp,
    this.status,
    this.type,
    this.fee,
    this.message,
    this.blockId,
    this.from,
    this.to,
    this.data,
  });



  factory Tx.fromJson(Map<String, dynamic> json){
    return Tx(
      id: json['id'] == null? 0: json['id'],
      hash: json['hash'] == null? "": json['hash'],
      timestamp: json['timestamp'] == null? "": json['timestamp'],
      status: json['status'] == null? "": json['status'],
      type: json['type'] == null? "": json['type'],
      message: json['message'] == null? "": json['message'],
      blockId: json['blockId'] == null? 0: json['blockId'],
      from: json['from'] == null? "": json['from'],
      to: json['to'] == null? "": json['to'],
      data: TxData.fromJson(json['data']),
      fee: Fee.fromJson(json['fee']),
    );
  }
}