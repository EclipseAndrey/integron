import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/fun/BottomDialogs/BottomSheetSelectParam.dart';


void AddProductInCart (BuildContext context, int route, {Product product} )async{

    if(product == null)product = await ProductProvider.getProduct(route);
    if(product.params.length>0){
      ShowBottoomSheetSelectParams(context: context, formalize: false, indexSelect: (index){}, product: product);
    }else{
      BlocProvider.of<CartCubit>(context).add(product);

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