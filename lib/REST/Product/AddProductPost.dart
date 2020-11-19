import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/reqests.dart';

Future<int> addProductPost (Product product)async{
  String token = await tokenDB();
  product.token = token;
  String urlQuery = server14880+ "/apitest.php/createitem?"; //http://194.226.171.139:14880/apitest.php/setaddress?address=
  print(urlQuery);
  var response;


    Map<String, String> headers =  HashMap();
    headers['Content-type'] = 'application/json';

    try {
      print(jsonEncode(product.toJson()));
    }catch(e){
      print(e.toString());
    }
    response = await http.post(urlQuery,encoding: Encoding.getByName('utf-8'), body: jsonEncode(product.toJson()), headers: headers).timeout(Duration(seconds: 5));

  print("addProduct "+response.body + response.statusCode.toString());

  if(response.statusCode == 200){
    print(json.decode(response.body)['mess']);
    return json.decode(response.body)['code'];
  }else{
    return null;
  }
}