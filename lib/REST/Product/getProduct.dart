import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Put.dart';


Future<Product> getProduct (int id)async{
  String url =  postConstructor(Methods.product.getItem)+"?id=$id";
  var response = await Rest.get(url);

  if(response is Put){
    return Product.err(response);
  }else{
    return Product.fromJson(response);
  }
}

