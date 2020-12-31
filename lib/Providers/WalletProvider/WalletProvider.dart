import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/Wallet/Balance.dart';
import 'package:integron/Utils/DB/Wallet/Tx.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/Utils/DB/Wallet/Filters.dart';

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

  static Future<List<Tx>> getTxs ({var filter})async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.wallet.getTxs);


    Map<String,dynamic> body = Map();
    body['token'] = token;


    if(filter != null){
      if(filter is All){ body['filter'] = filter.name.toLowerCase();}
      else if(filter is TokenSale){body['filter'] = filter.name.toLowerCase();}
      else if(filter is TransferTokens){body['filter'] = filter.name.toLowerCase();}
      else if(filter is ExchangeTokens){body['filter'] = filter.name.toLowerCase();}
      else if(filter is Delegate){body['filter'] = filter.name.toLowerCase();}
      else if(filter is PayProduct){body['filter'] = filter.name.toLowerCase();}
      else if(filter is PayService){body['filter'] = filter.name.toLowerCase();}
    }


    print(urlQuery);
    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put){
      return null;
    }else{
      return response['txs'].map((i)=>Tx.fromJson(i)).toList().cast<Tx>();
    }

  }

  static Future<Put> sendDel(String address, double amount)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.wallet.sendDel;


    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['address'] = address;
    body['amount'] = amount;



    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body,);

    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }

  }

}