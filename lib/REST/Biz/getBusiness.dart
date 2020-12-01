import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Biz/Business.dart';
import 'package:omega_qick/Utils/DB/Put.dart';



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