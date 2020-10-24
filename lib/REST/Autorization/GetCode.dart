import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/REST/SecureConnection/Connection.dart';
import 'package:omega_qick/REST/Servers.dart';

Future<int> GetCode (String num)async{
  String text;
  var data = await Connection.secure.key;
  text = data.text;


  String urlQuery = serverBD+ "/api.php/getcode?num=$num&text=$text";
  print(urlQuery);
  var response;
  try{
   response = await http.post(urlQuery).timeout(Duration(seconds: 5));

  }catch(e){
    return null;
  }


 
  print("getCode "+response.body);
  if(await response.statusCode == 200){

      var unescape = new HtmlUnescape();

      var a = json.decode(response.body);
      print("mess " + a['mess'].toString());
      print("code " + a['code'].toString());

      print("mess " + await Connection.secure.reCrypto(a['mess']));
      print("code " + await Connection.secure.reCrypto(a['code']));
      return int.parse(await Connection.secure.reCrypto(a['code']));

  }else{
    return null;
  }
}