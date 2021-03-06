import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';


class ForBiz {
   Future<Put> addProduct (Product product)async{
    String token = await tokenDB();
    product.token = token;
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.createProduct;


    Map<String,dynamic> body = product.toJson();

    print(urlQuery);
    print(body);
    Clipboard.setData(ClipboardData(text: jsonEncode(body).toString()));

    var response;

    response = await Rest.post(urlQuery, body);
    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }

  }

   Future<Put> deleteItem (int id)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.deleteProduct;

    List<int> ids = [id];
    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['id'] = ids.toString();


    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body);

    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }
  }
   Future<Put> hiddenItem (int id, int hidden)async{
     String token = await tokenDB();
     String urlQuery = Server.relevant+"/"+Api.api+"/"+ (hidden == 0?Methods.product.hiddenOn:Methods.product.hiddenOff);

     List<int> ids = [id];
     Map<String,dynamic> body = Map();
     body['token'] = token;
     body['id'] = ids.toString();


     print(urlQuery);
     print(body);
     var response;

     response = await Rest.post(urlQuery, body);

     if(response is Put) {
       return response;
     }else{
       return Put.fromJson(response);
     }
   }

   Future<Put> updateProduct (Product product, int id)async{

    String url = postConstructor(Methods.product.updateProduct);

    product.route = id;
    String token = await tokenDB();
    product.token = token;
    Map<String,dynamic> body = product.toJson();

    print(url);
    print(body);


    var response;
    response = await Rest.post(url, body);
    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }
  }

   Future<Put> upFull (int id,)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.upFull;

    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['id'] = id.toString();


    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body);

    response = await Rest.post(urlQuery, body);
    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }  }

  Future<Put> upOnly (int id, int id2)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.upOnly;

    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['idone'] = id.toString();
    body['idtwo'] = id2.toString();


    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body);

    response = await Rest.post(urlQuery, body);
    if(response is Put) {
      return response;
    }else{
      return Put.fromJson(response);
    }  }

}