import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';


class UserProvider {

   static Future<Put> setAddress (String address)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setAddress);

    Map <String,dynamic> body = Map();

    body['address'] = address;
    body['token'] = token;

    print(urlQuery);
    var response;
    response =await  Rest.post(urlQuery, body);
    if(response is Put) {
     return response;
    }else{
     return Put.fromJson(response);
    }
  }

   static Future<Put> setName (String name)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setName);

    Map<String,dynamic> body = Map();

    body['name'] = name;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put) {
     return response;
    }else{
     return Put.fromJson(response);
    }
  }

   static Future<Put> setPhoto (String photo)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setPhoto);

    Map <String,dynamic> body = Map();

    body['photo'] = photo;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = await  Rest.post(urlQuery, body);
    if(response is Put) {
     return response;
    }else{
     return Put.fromJson(response);
    }
  }

   static Future<Put> setRole (String role)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setRole);

    Map<String,dynamic> body = Map();

    body['role'] = role;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = await Rest.post(urlQuery, body);
    if(response is Put) {
     return response;
    }else{
     return Put.fromJson(response);
    }

  }

}