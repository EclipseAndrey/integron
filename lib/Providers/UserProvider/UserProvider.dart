import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';


class UserProvider {

   static Future<Put> setAddress (String address)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setAddress);

    Map body = Map();

    body['address'] = address;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = Rest.post(urlQuery, body);
    return response;

  }

   static Future<Put> setName (String name)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setName);

    Map body = Map();

    body['name'] = name;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = Rest.post(urlQuery, body);
    return response;

  }

   static Future<Put> setPhoto (String photo)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setPhoto);

    Map body = Map();

    body['photo'] = photo;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = Rest.post(urlQuery, body);
    return response;

  }

   static Future<Put> setRole (String role)async{
    String token = await tokenDB();
    String urlQuery = postConstructor(Methods.user.setRole);

    Map body = Map();

    body['role'] = role;
    body['token'] = token;

    print(urlQuery);
    var response;
    response = Rest.post(urlQuery, body);
    return response;

  }

}