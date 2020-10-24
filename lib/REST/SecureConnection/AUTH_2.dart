import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataAuth2.dart';

Future<DataAuth2> Auth_2(int partKey, String text, int pubKey)async{
  String url = "http://194.226.171.139:14880/api.php/auth2?partkey=$partKey&text=$text&pubkey=$pubKey";
  print(url);
  var response = await http.post(url);
  print(response.body);
  if(response.statusCode == 200)

    return DataAuth2.fromJson(jsonDecode(response.body));
  else return null;
}