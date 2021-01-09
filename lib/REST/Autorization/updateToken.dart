
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';



Future<Put> updateToken ()async{

  String urlQuery = Server.relevant+ "/"+Api.api+"/"+Methods.auth.updateToken;

  String token = await tokenDB();
  Map<String, dynamic> map = Map<String, dynamic>();
  map['token'] = token;

  print(urlQuery);
  print(map.toString());

  var response;
  response = await Rest.post(urlQuery, map);

  return response;
}