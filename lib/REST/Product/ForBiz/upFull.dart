import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';

Future<Put> upFull (int id)async{
  String token = await tokenDB();
  String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.upFull;

  Map<String,dynamic> body = Map();
  body['token'] = token;
  body['id'] = id.toString();


  print(urlQuery);
  print(body);
  var response;

  response = await Rest.post(urlQuery, body);

  return response;
}