import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataAuth1.dart';

Future<DataAuth1> Auth_1(int pubKey, String text)async{
  String url = "http://194.226.171.139:14880/api.php/auth1?pubkey=$pubKey&text=$text";
  var response = await http.post(url);
  print(response.body);
  if(response.statusCode == 200)
  return DataAuth1.fromJson(jsonDecode(response.body));
  else return null;
}