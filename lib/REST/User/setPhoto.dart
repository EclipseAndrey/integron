import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';

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