import 'dart:convert';

import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/reqests.dart';
import 'package:http/http.dart' as http;


Future<List<Category>> getCategories()async{
  List list;
  String url = server14880+"/api.php/getcategories?parrent=0";

  print(url);
  var response = await http.get(url);

  if(response.statusCode == 200){
    if(json.decode(response.body)['code'] == 200){
      list = json.decode(response.body)['mess'].map((i)=> Category.fromJson(i)).toList().cast<Category>();
      return list;
    }

    else return null;
  }else return null;


}