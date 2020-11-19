import 'dart:convert';

import 'package:omega_qick/Utils/DB/TxHistory/InfoWallet.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';
import 'package:http/http.dart' as http;

Future<InfoWallet> getBalance ()async{
  String token = await tokenDB();


  String url = server14880+"/api.php/balance?token=$token";
  print(url);
  var r = await http.get(url);
  
  if(r.statusCode==200){
    var parse = json.decode(r.body);
    if(parse['code']==200){
      print("get balance $parse");
      return InfoWallet.fromJson(parse);
    }else{
      print(parse['code']);
      return null;
    }
  }else{
    return null;
  }
  
}