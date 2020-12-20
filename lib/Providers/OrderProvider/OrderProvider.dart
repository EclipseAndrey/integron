import 'package:integron/Utils/DB/Orders/Order.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';

import 'ForBiz/ForBiz.dart';


class OrderProvider{

  static ForBiz get forBiz => ForBiz();
  static Future<List<Order>> getOrders ()async{
    String token = await tokenDB();


    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.getOrders;

    Map <String, dynamic>body = Map();
    body['token'] = token;


    print(body.toString());
    print(urlQuery);


    var response;
    response = await Rest.post(urlQuery, body, secureDown: false);
    if(response is Put){
      return null;
    }else{
      return response['products'].map((i)=>Order.fromJson(i)).toList().cast<Order>();
    }
  }

  static Future<Put> makeOrder (List<int>ids, int count, {List<String> params, String comment,String email} )async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.makeOrder;


    Map <String, dynamic>body = Map();
    body['token'] = token;
    body['ids'] = ids;
    body['count'] = count;
    // ignore: unnecessary_statements
    params != null?body['params'] = params:null;
    // ignore: unnecessary_statements
    comment != null?body['comment'] = comment:null;
    email != null?body['email'] = email:null;

    print(urlQuery);
    print(body.toString());


    var response;

    response = await Rest.post(urlQuery, body);
    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }
  }


}