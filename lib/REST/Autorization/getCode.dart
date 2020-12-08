import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';

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