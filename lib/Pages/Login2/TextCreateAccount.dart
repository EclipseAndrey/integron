import 'package:flutter/cupertino.dart';

import 'Style.dart';


Widget TextCreateAccount (BuildContext context, minusFontsSize){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Создать аккаунт", style:  TextStyle(color:  cMainBlack, fontSize:  27 - minusFontsSize, fontWeight: FontWeight.w400, fontStyle:  FontStyle.normal),),
      SizedBox(height: 20,),
      Text("с помощью мобильного", style: TextStyle(color:  cMainBlack, fontSize: 16 - minusFontsSize, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600))
    ],
  );
}