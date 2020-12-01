import 'package:omega_qick/Utils/DB/Orders/Order.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';


class ForBiz{


  static Future<List<Order>> getOrders ()async{
    String token = await tokenDB();

    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.getOrdersBiz;

    Map body = Map();
    body['token'] = token;


    print(body);
    print(urlQuery);


    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put){
      return null;
    }else{
      return response.map((i)=>Order.fromJson(i)).toList().cast<Order>();
    }
  }
}