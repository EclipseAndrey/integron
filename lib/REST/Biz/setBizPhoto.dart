import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';

Future<Put> setBizPhoto (String photo)async{
  String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.biz.setBizPhoto;


  String token = await tokenDB();

  Map<String, dynamic> map = Map<String, dynamic>();
  map['token'] = token;
  map['photo'] = photo;


  print(urlQuery);
  print(map.toString());

  var response;
  response = await Rest.post(urlQuery, map);

  return response;
}