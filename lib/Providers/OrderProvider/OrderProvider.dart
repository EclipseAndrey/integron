import 'package:omega_qick/Utils/DB/Orders/Order.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';


class OrderProvider{

  static Future<List<Order>> GetOrders (bool forBiz)async{
    String token = await tokenDB();


    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.getOrders;

    Map body = Map();
    body['token'] = token;


    print(body.toString());
    print(urlQuery);


    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put){
      return null;
    }else{
      return response.map((i)=>Order.fromJson(i)).toList().cast<Order>();
    }
  }

  static Future<Put> makeOrder (List<int>ids, int count, {List<String> params, String comment} )async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.makeOrder;


    Map body = Map();
    body['token'] = token;
    body['ids'] = ids;
    body['count'] = count;
    // ignore: unnecessary_statements
    params != null?body['params'] = params:null;
    // ignore: unnecessary_statements
    comment != null?body['comment'] = comment:null;

    print(urlQuery);
    print(body.toString());


    var response;

    response = await Rest.post(urlQuery, body);
    return response;
  }


}