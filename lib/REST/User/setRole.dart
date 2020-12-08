import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';

Future<Put> setRole (String role)async{
  String token = await tokenDB();
  String urlQuery = postConstructor(Methods.user.setRole);

  Map body = Map();

  body['role'] = role;
  body['token'] = token;

  print(urlQuery);
  var response;
  response = Rest.post(urlQuery, body);
  return response;

}