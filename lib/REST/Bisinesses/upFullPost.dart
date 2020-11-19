import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';

Future<int> upFullPost (int route)async{
  String token = await tokenDB();
  String urlQuery = server14880+ "/api.php/upfull?id=$route&token=$token"; //http://194.226.171.139:14880/api.php/upfull?token=u1lTviHsXBAnODhmL3Zrx5Rco&id=10
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
  print("upFull REST "+response.body);
  if(response.statusCode == 200){
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}