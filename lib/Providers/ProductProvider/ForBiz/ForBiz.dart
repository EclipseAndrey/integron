import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';


class ForBiz {
   Future<Put> addProduct (Product product)async{
    String token = await tokenDB();
    product.token = token;
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.createProduct;


    Map<String,dynamic> body = product.toJson();

    print(urlQuery);
    print(body);

    var response;

    response = await Rest.post(urlQuery, body);
    return response;

  }

   Future<Put> deleteItem (int id)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.deleteProduct;

    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['id'] = id.toString();


    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body);

    return response;
  }

   Future<Put> updateProduct (Product product, {int id})async{

    String url = postConstructor(Methods.product.updateProduct);

    String token = await tokenDB();
    product.token = token;
    Map<String,dynamic> body = product.toJson();

    print(url);
    print(body);

    var response;
    response = Rest.post(url, body);
    return response;

  }

   Future<Put> upFull (int id,)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.upFull;

    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['id'] = id.toString();


    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body);

    return response;
  }

  Future<Put> upOnly (int id, int id2)async{
    String token = await tokenDB();
    String urlQuery = Server.relevant+"/"+Api.api+"/"+Methods.product.upOnly;

    Map<String,dynamic> body = Map();
    body['token'] = token;
    body['idone'] = id.toString();
    body['idtwo'] = id2.toString();


    print(urlQuery);
    print(body);
    var response;

    response = await Rest.post(urlQuery, body);

    return response;
  }

}