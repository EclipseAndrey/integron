import 'dart:convert';


import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<int> GetSetName (String name)async{
  String token = await tokenDB();
  String urlQuery = serverBD+ "/api.php/renameuser?name=$name&token=$token";
  print(urlQuery);
  var response;
  try{
    response = await http.post(urlQuery, body: "{\"name\":\"$name\",\"token\":\"$token\"}").timeout(Duration(seconds: 5));
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