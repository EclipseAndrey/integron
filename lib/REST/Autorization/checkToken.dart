import 'package:flutter/cupertino.dart';
import 'package:integron/AutoRoutes.dart';
import 'package:integron/Utils/DB/Autorization/InfoToken/InfoToken.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/Utils/fun/ExitAccount.dart';

Future<InfoToken> checkToken (BuildContext context)async{

  String token = await tokenDB();
  String urlQuery = Server.relevant+ "/"+Api.api+"/"+Methods.auth.checkToken;

  Map<String, dynamic> map = Map<String, dynamic>();
  map['token'] = token;
  

  var response;
  response = await Rest.post(urlQuery, map);

  if(response is Put){
    if(response.error == 4){
      await ExitAccount();
      AutoRoutes(context);
    }else
    return InfoToken.err(response);
  }else{
    return InfoToken.fromJson(response);
  }
}