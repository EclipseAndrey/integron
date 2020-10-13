import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:omega_qick/REST/Servers.dart';

Future<int> GetCode (String num)async{
  String urlQuery = serverBD+ "/api.php/getcode?num=$num";
  print(urlQuery);
  var response;
  try{
   response = await http.get(urlQuery).timeout(Duration(seconds: 5));

  }catch(e){
    return null;
  }

  print("getCode "+response.body);
  if(await response.statusCode == 200){
    var a = json.decode(response.body);
    print("code "+a['code'].toString());
    return a['code'];
  }else{
    return null;
  }
}