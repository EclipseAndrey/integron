import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/Wallet/Balance.dart';
import 'package:integron/Utils/DB/Wallet/Tx.dart';
import 'package:integron/Utils/DB/tokenDB.dart';


class WalletProvider {

  static Future<Balance> getBalance ()async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.wallet.getBalance);

    Map body = Map<String,dynamic>();
    body['token'] = token;

    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put){
      return Balance.err(response);
    }else{
      return Balance.fromJson(response);
    }
  }

  static Future<List<Tx>> getTxs ()async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.wallet.getTxs);

    Map<String,dynamic> body = Map();
    body['token'] = token;

    print(urlQuery);
    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put){
      return null;
    }else{
      return response['txs'].map((i)=>Tx.fromJson(i)).toList().cast<Tx>();
    }

  }



}