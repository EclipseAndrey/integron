import 'package:http/http.dart' as http;
import 'package:omega_qick/Parse/CheckCode.dart';
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
  print("checkCode "+response.body);
  if(response.statusCode == 200){
    return CheckCode.fromJson(response.body);
  }else{
    return null;
  }
}