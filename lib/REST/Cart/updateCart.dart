import 'dart:convert';

import 'package:omega_qick/Utils/fun/Cart/CartModelForLocalDb.dart';
import 'package:omega_qick/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<bool> updateCart ()async{
  final prefs = await SharedPreferences.getInstance();
  List<Map> ids = [];

  for(int i = 0; i < cartList.length;i++){
    List<int> params = [];
    for(int j=0;j < cartList[i].params.length;j++){
      params.add(cartList[i].params[j].select);
    }
   ids.add(CartModel(id: cartList[i].route, count: cartList[i].counter, params: params).toJson());
  }
  String res = json.encode(ids);
  print(res);
  prefs.setString("cart", res);
}