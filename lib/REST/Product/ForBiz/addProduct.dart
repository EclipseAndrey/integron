import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/Rest.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';

Future<Put> addProduct (Product product, bool edit, {int id})async{
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