import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/REST/Methods.dart';
import 'package:omega_qick/REST/PostConstructor.dart';
import 'package:omega_qick/REST/Rest.dart';

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