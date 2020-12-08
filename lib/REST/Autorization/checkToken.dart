import 'package:integron/Utils/DB/Autorization/InfoToken/InfoToken.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';

Future<InfoToken> checkToken ()async{

  String token = await tokenDB();
  String urlQuery = Server.relevant+ "/"+Api.api+"/"+Methods.auth.checkToken;

  Map<String, dynamic> map = Map<String, dynamic>();
  map['token'] = token;
  

  var response;
  response = await Rest.post(urlQuery, map);

  if(response is Put){
    return InfoToken.err(response);
  }else{
    return InfoToken.fromJson(response);
  }
}