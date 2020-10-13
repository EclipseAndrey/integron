import 'package:http/http.dart' as http;
import 'package:omega_qick/Parse/CheckCode.dart';

Future<CheckCode> getCheckCode (String num)async{
  String urlQuery = "";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("getCode "+response.body);
  if(response.statusCode == 200){
    return CheckCode.fromJson(response.body);
  }else{
    return null;
  }
}