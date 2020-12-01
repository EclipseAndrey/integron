import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Autorization/CheckCode.dart';
import 'package:omega_qick/Utils/DB/Put.dart';



Future<CheckCode> checkCode (String num, String code)async{


  String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.auth.checkCode;

    final body = Map<String, dynamic>();
    body['num'] = num;
    body['code'] =code;


  print(urlQuery);
  print(body);


  var response;

  response = await Rest.post(urlQuery, body);

  if(response is Put){
    return CheckCode.err(response);
  }else{
    return CheckCode.fromJson(response);
  }
}