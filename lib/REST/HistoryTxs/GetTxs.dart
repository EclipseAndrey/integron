import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/TxHistory/Tx.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';



Future<List<Tx>> getTxs() async {

  String token = await tokenDB();
  String urlQuery = server14880+"/apitest.php/history?token=$token";
  var response;
  try {
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }

  print("get Txs "+response.body);


  if(response.statusCode == 200) {
    var r = jsonDecode(response.body);
    return r['txs'] == null?null:r['txs'].map((i)=>Tx.fromJson(i)).toList().cast<Tx>();
  }else{
    return null;
  }

}