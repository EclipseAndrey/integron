import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';


import 'ForBiz/ForBiz.dart';
import 'package:integron/Utils/DB/tokenDB.dart';


class ProductProvider{

  static Future<List<Product>> getItems({int offset, int limit, int type})async{

    String url = postConstructor(Methods.product.getItems);

    Map<String,dynamic> body = Map();

    if(offset != null || limit != null || type != null){
      url += "?";
      int count =0;
      if(offset != null){
        if(count != 0)url+="&";
        url+="offset=$offset";
        body['offset'] = offset;
        count++;
      }
      if(limit != null){
        if(count != 0)url+="&";
        url+="limit=$limit";
        body['limit'] = limit;

        count++;
      }
      if(type != null){
        if(count != 0)url+="&";
        url+="type=$type";
        body['type'] = type;

        count++;
      }
    }




    print(url);
    var response = await Rest.post(url, body, secureDown: false);

    if(response is Put){
      return null;
    }else{
      return response['products'].map((i)=>Product.fromJson(i)).toList().cast<Product>();
    }
  }

  static Future<Product> getProduct (int id)async{

     String token = await tokenDB();
    String url =  postConstructor(Methods.product.getItem)+"?id=$id";

    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['id'] = id;


    var response = await Rest.post(url, body, secureDown: false);

    if(response is Put){
      print("ERR "+response.mess +" "+response.error.toString());
      return Product.err(response);
    }else{
      return Product.fromJson(response['product'][0]);
    }
  }

  static Future<Put> setFavorite(int id, bool setValue)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+(setValue?Methods.product.setFavorite:Methods.product.deleteFavorite);

    List<int> ids = [id];
    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['id'] = id;


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

  static Future<List<Product>> getFavorites({int limit, int offset, int type})async{

    String url = Server.relevant+"/"+Api.api+"/"+Methods.product.getFavorites;
    String token = await tokenDB();


    Map<String,dynamic> body = Map();
    body['token'] = token;
    if(offset != null || limit != null || type != null){
      url += "?";
      int count =0;
      if(offset != null){
        if(count != 0)url+="&";
        url+="offset=$offset";
        body['offset'] = offset;
        count++;
      }
      if(limit != null){
        if(count != 0)url+="&";
        url+="limit=$limit";
        body['limit'] = limit;

        count++;
      }
      if(type != null){
        if(count != 0)url+="&";
        url+="type=$type";
        body['type'] = type;

        count++;
      }
    }




    print(url);
    var response = await Rest.post(url, body, secureDown: false);

    if(response is Put){
      return null;
    }else{
      return response['products'].map((i)=>Product.fromJson(i)).toList().cast<Product>();
    }
  }

  static ForBiz get forBiz => ForBiz();

}