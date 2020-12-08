import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Biz/Business.dart';
import 'package:integron/Utils/DB/Put.dart';



Future<Business> getBusiness(int id)async{

  String url =  Server.relevant+"/"+Api.api+"/"+Methods.biz.getBusinesses+"?id=$id";

  print(url);

  var response;
  response = await Rest.get(url);


  if(response is Put){
    return Business.err(response);
  }else{
    return Business.fromJson(response);
  }

}