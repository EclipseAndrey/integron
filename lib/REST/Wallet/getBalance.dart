import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/Wallet/Balance.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<Balance> getBalance ()async{
  String token = await tokenDB();
  String urlQuery = postConstructor(Methods.wallet.getBalance);

  Map body = Map();
  body['token'] = token;

  print(urlQuery);
  var response;
  response = Rest.post(urlQuery, body);
  if(response is Put){
    return Balance.err(response);
  }else{
    return Balance.fromJson(response);
  }

}