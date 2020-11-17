import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';

Future<int> setBizPhoto (String photo)async{
  String token = await tokenDB();
  String urlQuery = server14880+ "/api.php/setbizphoto?photo=$photo&token=$token"; //http://194.226.171.139:14880/apitest.php/setaddress?address=
  print(urlQuery);
  var response;
  try{
    Map<String,String> body = {"photo":photo,"token":token};
    print(body.toString());

    Map<String, String> headers =  HashMap();
    // headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';

    response = await http.post(urlQuery,encoding: Encoding.getByName('utf-8'), body: json.encode(body), headers: headers).timeout(Duration(seconds: 5));   }catch(e){
    return null;
  }
  print("setBizPhoto "+response.body);
  if(response.statusCode == 200){
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}