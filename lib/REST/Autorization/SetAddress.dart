import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';

Future<int> GetSetAddress (String address)async{
  String token = await tokenDB();
  String urlQuery = server14880+ "/api.php/setaddress?address=$address&token=$token"; //http://194.226.171.139:14880/apitest.php/setaddress?address=
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("setAddress "+response.body);
  if(response.statusCode == 200){
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}