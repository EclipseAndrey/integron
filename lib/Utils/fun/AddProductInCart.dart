import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';

import '../../main.dart';

void AddProductInCart (BuildContext context, int route, {Product product} )async{
  bool find = false;
  for(int i = 0; i < cartList.length; i++){
    if(cartList[i].route==route){cartList[i].counter++; find = true;
    }
  }
  if(!find){
    if(product == null)product = await getProductForId(route);
    cartList.add(product);
  }
  Fluttertoast.showToast(
      msg: "Добавлено",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0
  );
}