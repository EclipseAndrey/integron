import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Biz/Business.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';


class BizProvider{

  static Future<Business> getBusiness(int id)async{

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

  static Future<Put> setBizDesc (String desc)async{
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.biz.setBizDesc;


    String token = await tokenDB();

    Map<String, dynamic> map = Map<String, dynamic>();
    map['token'] = token;
    map['desc'] = desc;


    print(urlQuery);
    print(map.toString());

    var response;
    response = await Rest.post(urlQuery, map);

    return response;
  }

  static Future<Put> setBizName (String name)async{
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.biz.setBizName;


    String token = await tokenDB();

    Map<String, dynamic> map = Map<String, dynamic>();
    map['token'] = token;
    map['name'] = name;


    print(urlQuery);
    print(map.toString());

    var response;
    response = await Rest.post(urlQuery, map);

    return response;
  }

  static Future<Put> setBizPhoto (String photo)async{
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.biz.setBizPhoto;


    String token = await tokenDB();

    Map<String, dynamic> map = Map<String, dynamic>();
    map['token'] = token;
    map['photo'] = photo;


    print(urlQuery);
    print(map.toString());

    var response;
    response = await Rest.post(urlQuery, map);

    return response;
  }

}