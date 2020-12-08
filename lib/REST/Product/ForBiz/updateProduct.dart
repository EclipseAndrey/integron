import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';

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