import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Put.dart';


Future<List<Category>> getCategories()async{

  String url = Server.relevant+"/"+Api.api+"/"+Methods.category.getCategories;

  print(url);
  var response = await Rest.get(url);

  if(response is Put){
    return null;
  }else{
    return response.map((i)=>Category.fromJson(i)).toList().cast<Category>();
  }
}