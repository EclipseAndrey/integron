import 'dart:convert';

import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';
import 'package:http/http.dart' as http;

Future<double> getBalance ()async{
  String token = await tokenDB();


  String url = server14880+"/api.php/balance?token=$token";
  print(url);
  var r = await http.get(url);
  
  if(r.statusCode==200){
    var parse = json.decode(r.body);
    if(parse['code']==200){
      return double.parse(parse['balance']);
    }else{
      print(parse['code']);
      return null;
    }
  }else{
    return null;
  }
  
}