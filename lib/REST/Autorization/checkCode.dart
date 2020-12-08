import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Autorization/CheckCode.dart';
import 'package:integron/Utils/DB/Put.dart';



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