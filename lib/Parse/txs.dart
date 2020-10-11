import 'package:omega_qick/Parse/tx.dart';

class Txs {
  List<Tx> txs;
  Txs({this.txs});
  factory Txs.fromJson(Map<String, dynamic> json){
    return Txs(
      txs: json['txs'].map((i) => Tx.fromJson(i)),
    );
  }
}