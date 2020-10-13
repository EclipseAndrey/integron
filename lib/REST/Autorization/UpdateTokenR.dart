import 'package:http/http.dart' as http;
import 'package:omega_qick/REST/Servers.dart';

Future<int> UpdateTokenR (String token)async{
  String urlQuery = serverBD+ "/api.php/updatetoken?token=$token";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("UpdateToken "+response.body);
  if(response.statusCode == 200){
    if(response.body['code'] == 200)
    return response.body['token'];
    else return null;
  }else{
    return null;
  }
}