import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/fun/BottomSheetSelectParam.dart';

import '../../main.dart';
import 'Cart/UpdateCart.dart';

void AddProductInCart (BuildContext context, int route, {Product product} )async{
  bool find = false;
  for(int i = 0; i < cartList.length; i++){
    if(cartList[i].route==route){cartList[i].counter++; find = true; updateCart();
    }
  }
  if(!find){
    if(product == null)product = await getProductForId(route);
    if(product.params.length>0){
      ShowBottoomSheetSelectParams(context: context, formalize: false, indexSelect: (index){}, product: product);
    }else{
      cartList.add(product);updateCart();
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

  }else{
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

}