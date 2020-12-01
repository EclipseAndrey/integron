// import 'package:omega_qick/REST/Methods.dart';
// import 'package:omega_qick/REST/PostConstructor.dart';
// import 'package:omega_qick/REST/Rest.dart';
// import 'package:omega_qick/Utils/DB/Products/Product.dart';
// import 'package:omega_qick/Utils/DB/Put.dart';
//
// Future<List<Product>> getItems({int offset, int limit, int type})async{
//
//   String url = postConstructor(Methods.product.getItems);
//   if(offset != null || limit != null || type != null){
//     url += "?";
//     int count =0;
//     if(offset != null){
//       if(count != 0)url+="&";
//       url+="offset=$offset";
//       count++;
//     }
//     if(limit != null){
//       if(count != 0)url+="&";
//       url+="limit=$limit";
//       count++;
//     }
//     if(type != null){
//       if(count != 0)url+="&";
//       url+="type=$type";
//       count++;
//     }
//   }
//
//   print(url);
//   var response = await Rest.get(url);
//
//   if(response is Put){
//     return null;
//   }else{
//     return response.map((i)=>Product.fromJson(i)).toList().cast<Product>();
//   }
// }