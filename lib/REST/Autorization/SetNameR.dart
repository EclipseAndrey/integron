import 'dart:convert';

import 'package:omega_qick/Authorization/tokenDB.dart';
import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;

Future<int> setNameR (String name)async{
  String token = await tokenDB();
  String urlQuery = serverBD+ "/api.php/setname?name=$name&token=$token";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("setName "+response.body);
  if(response.statusCode == 200){
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}