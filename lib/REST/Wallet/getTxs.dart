// import 'package:omega_qick/REST/Methods.dart';
// import 'package:omega_qick/REST/PostConstructor.dart';
// import 'package:omega_qick/REST/Rest.dart';
// import 'package:omega_qick/Utils/DB/Put.dart';
// import 'package:omega_qick/Utils/DB/Wallet/Tx.dart';
// import 'package:omega_qick/Utils/DB/tokenDB.dart';
//
// Future<List<Tx>> getTxs ()async{
//   String token = await tokenDB();
//   String urlQuery = postConstructor(Methods.wallet.getTxs);
//
//   Map body = Map();
//   body['token'] = token;
//
//   print(urlQuery);
//   var response;
//   response = Rest.post(urlQuery, body);
//   if(response is Put){
//     return null;
//   }else{
//     return response.map((i)=>Tx.fromJson(i)).toList().cast<Tx>();
//   }
//
// }