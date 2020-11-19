import 'dart:collection';
import 'dart:convert';


import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/Orders/Order.dart';
import 'package:omega_qick/Utils/DB/Params/Params.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<List<Order>> GetOrders (bool forBiz)async{
  String token = await tokenDB();
  String method = forBiz?"mypurchase":"myorders";
  String urlQuery = serverBD+ "/api.php/"+method;
  print(urlQuery);

  Map body = Map();
  body['token'] = token;


  print(body.toString());


  var response;
  try{
    Map<String, String> headers =  HashMap();
    headers['Content-type'] = 'application/json';
    response = await http.post(urlQuery,encoding: Encoding.getByName('utf-8'), body: json.encode(body), headers: headers).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("get Orders "+response.body);
  if(response.statusCode == 200){
    var r= jsonDecode(response.body);
    if(r['code'] == 200){
      List<Order> orders;
      orders = r['products'].map((i)=> Order.fromJson(i)).toList().cast<Order>();
      return orders;
    }else{
      return null;
    }
  }else{
    return null;
  }
}