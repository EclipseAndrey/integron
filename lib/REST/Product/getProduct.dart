import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';


Future<Product> getProduct (int id)async{
  String url =  postConstructor(Methods.product.getItem)+"?id=$id";
  var response = await Rest.get(url);

  if(response is Put){
    return Product.err(response);
  }else{
    return Product.fromJson(response);
  }
}

