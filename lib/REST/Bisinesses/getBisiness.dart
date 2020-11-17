import 'dart:convert';

import 'package:omega_qick/Utils/DB/Bisiness/GetBusinessModel.dart';
import 'package:omega_qick/reqests.dart';
import 'package:http/http.dart' as http;



Future<Business> getBusiness(int id)async{

 //todo url
  String url =  server14880+"/api.php/getbiz?id=$id";
  print(url);
  try{
    var response = await http.get(url);
    if(response.statusCode == 200){
      var r = json.decode(response.body);
      if(r['code']==200){
        print(r.toString());
        return Business.fromJson(r);
      }
    }else{
      return Business.error();
    }
  }catch(e){
    return Business.error();
  }
  return Business.error();
}