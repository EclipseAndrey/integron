import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';

Future<int> upOnlyPost (int route, int route2)async{
  String token = await tokenDB();
  String urlQuery = server14880+ "/api.php/up?idone=$route&idtwo=$route2&token=$token"; //http://194.226.171.139:14880/api.php/up?token=FPuX86VGJCnSYMBtZxdKsH7oW&idone=1&idtwo=2
  print(urlQuery);
  var response;
  // try{
  //   Map<String,String> body = {"desc":desc,"token":token};
  //   print(body.toString());
  //
  //   Map<String, String> headers =  HashMap();
  //   // headers['Accept'] = 'application/json';
  //   headers['Content-type'] = 'application/json';
  //
  //   response = await http.post(urlQuery,encoding: Encoding.getByName('utf-8'), body: json.encode(body), headers: headers).timeout(Duration(seconds: 5));
  // }catch(e){
  //   return null;
  // }

  response = await http.get(urlQuery);
  print("up REST "+response.body);
  if(response.statusCode == 200){
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}