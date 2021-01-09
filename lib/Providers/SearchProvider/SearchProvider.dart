
import 'package:integron/REST/Api.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/DB/tokenDB.dart';

class SearchProvider{

  static Future<List<Product>> search(String searchText, {int offset, int limit, int type})async{
    String url = postConstructor(Methods.search.search)+"?search=$searchText";
    Map<String,dynamic> body = Map();

    String token = await tokenDB();

    if(offset != null || limit != null || type != null){
      // url += "?";
      int count =1;
      if(offset != null){
        if(count != 0)url+="&";
        url+="offset=$offset";
        body['offset'] = offset;
        count++;
      }
      if(limit != null){
        if(count != 0)url+="&";
        url+="limit=$limit";
        body['limit'] = limit;

        count++;
      }
      if(type != null){
        if(count != 0)url+="&";
        url+="type=$type";
        body['type'] = type;

        count++;
      }
    }

    body['token'] = token;
    body['search'] = searchText;


    var response = await Rest.post(url, body, secureDown: false);
    if(response is Put){
      return null;
    }else{
      return response['products'].map((i)=>Product.fromJson(i)).toList().cast<Product>();
    }
  }


}