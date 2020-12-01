import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';



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