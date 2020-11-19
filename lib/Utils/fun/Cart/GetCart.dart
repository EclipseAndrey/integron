import 'dart:convert';

import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/fun/Cart/CartModelForLocalDb.dart';
import 'package:omega_qick/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getCart ()async{
  final prefs = await SharedPreferences.getInstance();
  List<CartModel> ids = [];
  ids = prefs.getString("cart") == null?"[]":jsonDecode(prefs.getString("cart")).map((i)=>CartModel.fromJson(i)).toList().cast<CartModel>();

  List<Product> products = [];
  for(int i = 0; i < ids.length; i++){
    Product p = await getProductForId(ids[i].id);
    for(int j = 0; j < p.params.length;j++){
      p.params[j].select = ids[i].params[j];
    }
    p.counter = ids[i].count;
    products.add(p);
  }
  cartList = products;
}