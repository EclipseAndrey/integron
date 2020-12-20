import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Biz/Business.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';


class BizProvider{

  static Future<Business> getBusiness(int id)async{

    String url =  Server.relevant+"/"+Api.api+"/"+Methods.biz.getBusinesses+"?id=$id";

    Map<String,dynamic> body = Map();

    body['id'] = id;
    body['token'] = await tokenDB();

    print(url);

    var response;
    response = await Rest.post(url, body, secureDown: false);


    if(response is Put){
      print("biz" + response.mess);

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

    if(response is Put){
      return response;
    }else{
      return Put(error: response['code'], mess: response['mess'], localError: false);
    }
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

    if(response is Put){
      return response;
    }else{
      return Put(error: response['code'], mess: response['mess'], localError: false);
    }
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

    if(response is Put){
      return response;
    }else{
      return Put(error: response['code'], mess: response['mess'], localError: false);
    }
  }

}