import 'dart:convert';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/fun/Cart/CartModelForLocalDb.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider{

  static Future<List<Product>> getCart ()async{
    final prefs = await SharedPreferences.getInstance();
    List<CartModel> ids = [];
    ids = prefs.getString("cart") == null?[]:jsonDecode(prefs.getString("cart")).map((i)=>CartModel.fromJson(i)).toList().cast<CartModel>();

    List<Product> products = [];
    for(int i = 0; i < ids.length; i++){
      Product p = await ProductProvider.getProduct(ids[i].id);
      for(int j = 0; j < p.params.length;j++){
        p.params[j].select = ids[i].params[j];
      }
      p.counter = ids[i].count;
      if(p!=null && p.errors == null)products.add(p);
    }
    return products;
  }

  static Future<bool> updateCart (List<Product> cartList)async{
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

}