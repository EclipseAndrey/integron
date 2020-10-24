import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:omega_qick/Parse/CheckCode.dart';
import 'package:omega_qick/REST/SecureConnection/Connection.dart';
import 'package:omega_qick/REST/Servers.dart';

Future<CheckCode> CheckCodeR (String num, String code)async{
  String urlQuery = serverBD+ "/api.php/checkcode?num=$num&code=$code";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("checkCode =========="+response.body+"===========");
  if(response.statusCode == 200){
    return CheckCode.fromJson(json.decode(response.body));
  }else{
    return null;
  }
}


Future<CheckCode> CheckCodeP (String num, String code)async{
  var con = await Connection.secure.key;
  String text = con.text;
   var Cnum = await Connection.secure.crypto(num.toString());
   var Ccode = await Connection.secure.crypto(code);

  String urlQuery = serverBD+ "/api.php/checkcode";
  print(urlQuery);

  Map<String,dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['\"text\"'] = "\""+text+"\"";
    map['\"num\"'] = Cnum.toString();
    map['"code"'] =Ccode.toString();
    print(map.toString());
    return map;
  }


  Map<String, String> headers = new HashMap();
  // headers['Accept'] = 'application/json';
  headers['Content-type'] = 'application/json';

  var response;

  response = await http.post(urlQuery, encoding: Encoding.getByName('utf-8'), body: toMap().toString(), headers: headers);
  
  print("checkCode ==========="+response.body+"===========");
  if(response.statusCode == 200) {
    String code = await Connection.secure.reCrypto(json.decode(await response.body)['code']);
    print("response $code ");
    if (code == "200"){
      String token = await Connection.secure.reCrypto(
          json.decode(await response.body)['token']);
    return CheckCode(code: int.parse(code), token: token);
  }
    else return CheckCode.err();
  }else{
    return null;
  }
}