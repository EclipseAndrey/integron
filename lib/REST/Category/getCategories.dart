import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Put.dart';


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