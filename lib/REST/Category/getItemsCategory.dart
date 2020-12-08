import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';

//List<ProductShort>
Future<List<ProductShort>> getItemsCategory(int id, {int offset, int limit, int type})async {


  String url = Server.relevant+"/"+Api.api+"/"+Methods.category.getItems+"?id=$id";
  if (offset != null || limit != null || type != null) {
    int count = 1;
    if (offset != null) {
      if (count != 0) url += "&";
      url += "offset=$offset";
      count++;
    }
    if (limit != null) {
      if (count != 0) url += "&";
      url += "limit=$limit";
      count++;
    }
    if (type != null) {
      if (count != 0) url += "&";
      url += "type=$type";
      count++;
    }
  }

  print(url);
  var response = await Rest.get(url);
  if(response is Put){
    return null;
  }else{
    return response['product'].map((i)=>ProductShort.fromJson(i)).toList().cast<ProductShort>();
  }
}