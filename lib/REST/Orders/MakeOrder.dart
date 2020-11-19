import 'dart:collection';
import 'dart:convert';


import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/Params/Params.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<List> makeOrder (List<int>ids, int count, {List<String> params, String comment} )async{
  String token = await tokenDB();
  String urlQuery = serverBD+ "/api.php/makeorder?";
  print(urlQuery);

  Map body = Map();
  body['token'] = token;
  body['ids'] = ids;
  body['count'] = count;
  // ignore: unnecessary_statements
  params != null?body['params'] = params:null;
  // ignore: unnecessary_statements
  comment != null?body['comment'] = comment:null;

  print(body.toString());


  var response;
  try{
    Map<String, String> headers =  HashMap();
    headers['Content-type'] = 'application/json';
    response = await http.post(urlQuery,encoding: Encoding.getByName('utf-8'), body: json.encode(body), headers: headers).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("makeOrder "+response.body);
  if(response.statusCode == 200){
    List res = [];
    res = [json.decode(response.body)['code'],json.decode(response.body)['mess']];
    return res;
  }else{
    List res = [];
    res = [json.decode(response.body)['code'],json.decode(response.body)['mess']];
    return res;
  }
}