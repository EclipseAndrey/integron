import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;

Future<int> setNameR (String name)async{
  String urlQuery = serverBD+ "/api.php/setname?name=$name";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("setName "+response.body);
  if(response.statusCode == 200){
    return response.body['code'];
  }else{
    return null;
  }
}