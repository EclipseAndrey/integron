import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';

Future<Put> makeOrder (List<int>ids, int count, {List<String> params, String comment} )async{
  String token = await tokenDB();
  String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.makeOrder;


  Map body = Map();
  body['token'] = token;
  body['ids'] = ids;
  body['count'] = count;
  // ignore: unnecessary_statements
  params != null?body['params'] = params:null;
  // ignore: unnecessary_statements
  comment != null?body['comment'] = comment:null;

  print(urlQuery);
  print(body.toString());


  var response;

  response = await Rest.post(urlQuery, body);
  return response;
}