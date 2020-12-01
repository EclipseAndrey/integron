import 'package:omega_qick/Utils/DB/Autorization/InfoToken/InfoToken.dart';
import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';

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