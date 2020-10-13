import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/REST/Servers.dart';

Future<InfoToken> checkToken (String token)async{
  String urlQuery = serverBD+ "/api.php/checktoken?token=$token";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("checkToken "+response.body);
  if(response.statusCode == 200){
    return InfoToken.fromJson(response.body);
  }else{
    return null;
  }
}