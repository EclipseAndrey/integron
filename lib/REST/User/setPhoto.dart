import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';

Future<Put> setPhoto (String photo)async{
  String token = await tokenDB();
  String urlQuery = postConstructor(Methods.user.setPhoto);

  Map body = Map();

  body['photo'] = photo;
  body['token'] = token;

  print(urlQuery);
  var response;
  response = Rest.post(urlQuery, body);
  return response;

}