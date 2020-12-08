import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';

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