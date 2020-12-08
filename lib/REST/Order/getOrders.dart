import 'package:integron/Utils/DB/Orders/Order.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';

Future<List<Order>> GetOrders (bool forBiz)async{
  String token = await tokenDB();


  String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.order.getOrders;

  Map <String,dynamic> body = Map();
  body['token'] = token;


  print(body.toString());
  print(urlQuery);


  var response;
  response = await Rest.post(urlQuery, body);
  if(response is Put){
    return null;
  }else{
    return response['products'].map((i)=>Order.fromJson(i)).toList().cast<Order>();
  }
}