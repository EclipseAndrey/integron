import 'package:integron/REST/Methods.dart';
import 'package:integron/REST/PostConstructor.dart';
import 'package:integron/REST/Rest.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Put.dart';

class SearchProvider{

  static Future<List<ProductShort>> search(String searchText, {int offset, int limit, int type})async{
    String url = postConstructor(Methods.search.search)+"?search=$searchText";
    Map<String,dynamic> body = Map();

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

    var response = await Rest.get(url);
    if(response is Put){
      return null;
    }else{
      return response['products'].map((i)=>ProductShort.fromJson(i)).toList().cast<ProductShort>();
    }
  }


}