import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataAuth1.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';

Future<DataAuth1> Auth_1(int pubKey, String text)async{
  String url = Server.relevant+"/"+Api.api+"/auth1?pubkey=$pubKey&text=$text";
  var response = await http.post(url);
  print("==="+url+" "+response.body);
  print(response.body);
  if(response.statusCode == 200)
  return DataAuth1.fromJson(jsonDecode(response.body));
  else return null;
}