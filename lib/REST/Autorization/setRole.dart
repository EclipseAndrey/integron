import 'dart:convert';


import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<int> setRoleR (String role)async{
  String token = await tokenDB();
  String urlQuery = serverBD+ "/api.php/setrole?role=$role&token=$token";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("setRole "+response.body);
  if(response.statusCode == 200){
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}