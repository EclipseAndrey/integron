import 'dart:convert';

import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<int> AddWalletR (bool main, String seed, String address)async{
  String token = await tokenDB();
  String mainR = main?"1":"0";
  String urlQuery = serverBD+ "/api.php/addwallet?main=$mainR&seedphrase=$seed&address=$address&token=$token";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("AddWallet "+response.body);
  if(response.statusCode == 200){
    var a = json.decode(response.body);
    return a['code'];
  }else{
    return null;
  }
}