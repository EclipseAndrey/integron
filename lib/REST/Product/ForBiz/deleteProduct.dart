import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';

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