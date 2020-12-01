import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Put.dart';

import 'ForBiz/ForBiz.dart';


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
    var response = await Rest.post(url, body,);

    if(response is Put){
      return null;
    }else{
      return response['products'].map((i)=>Product.fromJson(i)).toList().cast<Product>();
    }
  }

  static Future<Product> getProduct (int id)async{
    String url =  postConstructor(Methods.product.getItem)+"?id=$id";
    var response = await Rest.get(url);

    if(response is Put){
      print("ERR "+response.mess +" "+response.error.toString());
      return Product.err(response);
    }else{
      return Product.fromJson(response['product'][0]);
    }
  }

  static ForBiz get forBiz => ForBiz();

}