import 'dart:convert';

import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:http/http.dart' as http;



Future<Product> getProductForId (int id)async{
  String url =  "http://194.226.171.139:14880/api.php/item?id=$id";
  print(url);
  var response = await http.get(url);

  if(response.statusCode == 200){
    var dec = json.decode(response.body);
    if(dec['code'] == 200){
      try {
        return Product.fromJson(dec['product']);
      }catch(e){
        print(dec['product']);
        print(e);
        return Product.error(1000);
      }
    }else{
      print(dec['mess']);
      return Product.error(dec['code']);
    }
  }else{
    return Product.error(response.statusCode);
  }
}

