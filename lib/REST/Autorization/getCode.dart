import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Put.dart';

Future<Put> getCode (String num)async{

  String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.auth.getCode;

  Map<String,dynamic> body = Map<String,dynamic>();
  body['num'] = num;

  print(urlQuery);
  print(body);

  var response;
  response = await Rest.post(urlQuery, body,);
  return response;

}